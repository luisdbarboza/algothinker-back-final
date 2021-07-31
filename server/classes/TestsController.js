const { performance } = require('perf_hooks');
const { VM } = require('vm2');
const chai = require('chai');
const expect = chai.expect;

const { pool: dbPool } = require('../database/db');
const { respondWithErrorMessage, updateTableById } = require('../helpers');

class TestsController {
  async getAllTests(req, res) {
    try {
      const sqlQuery = 'SELECT * FROM tests';
      const result = await dbPool.query(sqlQuery);
      const tests = result.rows;

      res.json({
        ok: true,
        tests,
      });
    } catch (err) {
      respondWithErrorMessage(res, err, 500);
    }
  }

  async createTest(req, res) {
    try {
      const { challengeId, input, output } = req.body;
      let sqlQuery = `INSERT INTO tests ( id_challenge, input_values, expected_result) `;
      sqlQuery += `VALUES ($1, $2, $3) RETURNING id`;
      const values = [challengeId, input, output];

      const result = await dbPool.query(sqlQuery, values);
      const testId = result.rows[0].id;

      res.status(201).json({
        ok: true,
        message: 'Prueba registrada',
        testId,
      });
    } catch (err) {
      respondWithErrorMessage(res, err, 500);
    }
  }

  evaluateTest = async (req, res) => {
    const vm = new VM();

    try {
      const { challengeId } = req.body;
      let { userCode } = req.body;
      const userId = req.user.id;

      let sqlQuery = `SELECT * FROM getTestData WHERE challengeId=$1`;
      let values = [challengeId];
      let result = await dbPool.query(sqlQuery, values);
      const testsData = result.rows;

      let testsResults = [];

      let test_errors = 0;
      let success = false;
      let testNumber = 1;
      for (let test of testsData) {
        let testCode = userCode;
        let errors = 0;

        if (testCode[testCode.length - 1] !== ';') testCode += ';';

        const stringParams = this.#paramsToString(test.input_values);
        testCode += `${test.function_name}(${stringParams})`;

        const timerStart = performance.now();

        result = vm.run(testCode);

        const timerEnd = performance.now();

        const tookToExecute = (timerEnd - timerStart) / 1000;

        for (let expected of test.expected_result) {
          try {
            expect(result).to.deep.equal(expected);

            testsResults.splice(-1, errors);

            testsResults.push(
              `EXITO - Prueba #${testNumber} - ${
                test.function_name
              }(${stringParams}) - resultado = ${JSON.stringify(
                result
              )} - esperado - ${JSON.stringify(
                expected
              )} - Ejecutado en ${tookToExecute.toFixed(6)}ms`
            );

            errors = 0;
            break;
          } catch (err) {
            if (errors > 0) {
              testsResults.pop();
            }

            errors += 1;
            testsResults.push(
              `FALLO - Prueba #${testNumber} - ${
                test.function_name
              }(${stringParams}) - resultado = ${JSON.stringify(
                result
              )} - esperado - ${JSON.stringify(
                expected
              )} - Ejecutado en ${tookToExecute.toFixed(6)}ms`
            );
          }
        }

        if (errors > 0) {
          test_errors += 1;
        }

        testNumber++;
      }

      if (test_errors === 0 && testsResults.length > 0) {
        success = true;
      } else {
        success = false;
      }

      if (success) {
        sqlQuery = `INSERT INTO challenges_solved ( user_id, challenge_id ) `;
        sqlQuery += `VALUES ($1, $2) RETURNING id`;
        const values = [userId, challengeId];

        const result = await dbPool.query(sqlQuery, values);
        const challegeSolvedId = result.rows[0].id;

        res.status(201).json({
          ok: true,
          message: 'Reto completado',
          challegeSolvedId,
          results: testsResults,
        });
      } else {
        res.json({
          ok: false,
          message: 'Oops, se encontraron errores',
          results: testsResults,
        });
      }
    } catch (err) {
      res.status(400).json({
        ok: false,
        err: err.message,
      });
    }
  };

  #paramsToString(arrayOfParameters) {
    let string = '';
    let paramCounter = 0;
    for (let param of arrayOfParameters) {
      string += JSON.stringify(param);

      paramCounter++;
      if (paramCounter !== arrayOfParameters.length) {
        string += ',';
      }
    }

    return string;
  }

  async updateTest(req, res) {
    const customError = 'Prueba inexistente';

    try {
      let sqlQuery;
      let result;
      let values;
      const testId = req.params.id;

      sqlQuery = updateTableById(testId, 'tests', req.body);

      values = Object.keys(req.body).map((key) => req.body[key]);

      result = await dbPool.query(sqlQuery, values);

      if (result.rowCount === 1) {
        res.json({
          ok: true,
          test: result.rows[0],
        });
      } else {
        throw new Error(customError);
      }
    } catch (err) {
      if (err.message != customError) respondWithErrorMessage(res, err, 500);
      else {
        respondWithErrorMessage(res, customError, 400);
      }
    }
  }

  async deleteChallenge(req, res) {
    try {
      let customError = 'Prueba inexistente';

      const testId = req.params.id;
      const sqlQuery = `DELETE FROM tests WHERE id=$1 RETURNING tests`;
      const values = [testId];
      const result = await dbPool.query(sqlQuery, values);

      if (result.rowCount === 1) {
        res.json({
          ok: true,
          message: 'Prueba borrada',
        });
      } else {
        throw new Error(customError);
      }
    } catch (err) {
      if (err.message != customError) respondWithErrorMessage(res, err, 500);
      else {
        customError = { message: err.message };
        respondWithErrorMessage(res, customError, 400);
      }
    }
  }
}

module.exports = new TestsController();
