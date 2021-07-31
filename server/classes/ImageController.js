const fs = require('fs/promises');
const path = require('path');

const { respondWithErrorMessage, deleteFile } = require('../helpers');

const groups = {
  topics: { folder: 'Topics' },
  users: { folder: 'Users' },
};

//despues
class ImageController {
  async upload(req, res) {
    try {
      if (process.env.ENVIROMENT === 'development') {
        const files = req.files;
        const type = req.params.type;

        if (!groups[type]) {
          throw new Error({
            message: 'Tipo inexistente e invalido',
          });
        }

        const filesUploaded = [];

        for (let file of files) {
          const folderPath = path.join(
            __dirname,
            `../uploads/${groups[type].folder}`
          );

          const fileContents = await fs.readFile(file.path);

          await fs.writeFile(
            path.join(folderPath, file.filename),
            fileContents
          );

          await fs.unlink(file.path);

          file.url = `${process.env.API_URL}/images/${groups[type].folder}/${file.filename}`;

          delete file.buffer;
          filesUploaded.push(file);
        }

        res.json({
          ok: true,
          data: filesUploaded,
        });
      }
    } catch (err) {
      for (let file of req.files) {
        deleteFile(file.path);
      }

      respondWithErrorMessage(res, err, 500);
    }
  }

  async sendFile(req, res) {
    const { type, filename } = req.params;

    if (!groups[type]) {
      return res.status(400).json({
        ok: false,
        message: 'Tipo invalido',
      });
    }

    res.sendFile(
      path.join(__dirname, `../uploads/${groups[type].folder}/${filename}`)
    );
  }
}

module.exports = new ImageController();
