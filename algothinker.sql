PGDMP                         y            algothinker2    13.3    13.3 8    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                        0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    25137    algothinker2    DATABASE     i   CREATE DATABASE algothinker2 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'Spanish_Mexico.1252';
    DROP DATABASE algothinker2;
                postgres    false            {           1247    25139    difficulty_levels    TYPE     W   CREATE TYPE public.difficulty_levels AS ENUM (
    'easy',
    'normal',
    'hard'
);
 $   DROP TYPE public.difficulty_levels;
       public          postgres    false            ~           1247    25146 
   user_roles    TYPE     F   CREATE TYPE public.user_roles AS ENUM (
    'admin',
    'regular'
);
    DROP TYPE public.user_roles;
       public          postgres    false            �            1259    25151 
   categories    TABLE     v   CREATE TABLE public.categories (
    id integer NOT NULL,
    title character varying(50) NOT NULL,
    icon jsonb
);
    DROP TABLE public.categories;
       public         heap    postgres    false            �            1259    25157    categories_id_seq    SEQUENCE     �   CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.categories_id_seq;
       public          postgres    false    200                       0    0    categories_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;
          public          postgres    false    201            �            1259    25159 
   challenges    TABLE     5  CREATE TABLE public.challenges (
    id integer NOT NULL,
    topic_id integer,
    title character varying(50),
    difficulty_level public.difficulty_levels DEFAULT 'easy'::public.difficulty_levels NOT NULL,
    heading character varying(2000) NOT NULL,
    function_name character varying(100) NOT NULL
);
    DROP TABLE public.challenges;
       public         heap    postgres    false    635    635            �            1259    25166    challenges_id_seq    SEQUENCE     �   CREATE SEQUENCE public.challenges_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.challenges_id_seq;
       public          postgres    false    202                       0    0    challenges_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.challenges_id_seq OWNED BY public.challenges.id;
          public          postgres    false    203            �            1259    25168    challenges_solved    TABLE     �   CREATE TABLE public.challenges_solved (
    id integer NOT NULL,
    user_id integer,
    challenge_id integer,
    try_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);
 %   DROP TABLE public.challenges_solved;
       public         heap    postgres    false            �            1259    25172    challenges_solved_id_seq    SEQUENCE     �   CREATE SEQUENCE public.challenges_solved_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 /   DROP SEQUENCE public.challenges_solved_id_seq;
       public          postgres    false    204                       0    0    challenges_solved_id_seq    SEQUENCE OWNED BY     U   ALTER SEQUENCE public.challenges_solved_id_seq OWNED BY public.challenges_solved.id;
          public          postgres    false    205            �            1259    25174    tests    TABLE     �   CREATE TABLE public.tests (
    id integer NOT NULL,
    input_values jsonb,
    expected_result jsonb,
    id_challenge integer
);
    DROP TABLE public.tests;
       public         heap    postgres    false            �            1259    25180    gettestdata    VIEW     ]  CREATE VIEW public.gettestdata AS
 SELECT challenges.id AS challengeid,
    tests.id AS testid,
    challenges.title,
    challenges.heading,
    challenges.difficulty_level,
    challenges.function_name,
    tests.input_values,
    tests.expected_result
   FROM (public.challenges
     JOIN public.tests ON ((challenges.id = tests.id_challenge)));
    DROP VIEW public.gettestdata;
       public          postgres    false    202    202    206    206    206    202    202    206    202    635            �            1259    25184    tests_id_seq    SEQUENCE     �   CREATE SEQUENCE public.tests_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.tests_id_seq;
       public          postgres    false    206                       0    0    tests_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.tests_id_seq OWNED BY public.tests.id;
          public          postgres    false    208            �            1259    25186    topics    TABLE       CREATE TABLE public.topics (
    id integer NOT NULL,
    title character varying(50) NOT NULL,
    icon jsonb,
    category_id integer,
    introduction text NOT NULL,
    introduction_image character varying(300) NOT NULL,
    lesson_data jsonb,
    visualization_data jsonb
);
    DROP TABLE public.topics;
       public         heap    postgres    false            �            1259    25192    topics_id_seq    SEQUENCE     �   CREATE SEQUENCE public.topics_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.topics_id_seq;
       public          postgres    false    209                       0    0    topics_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.topics_id_seq OWNED BY public.topics.id;
          public          postgres    false    210            �            1259    25194    users    TABLE     M  CREATE TABLE public.users (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    email character varying(50) NOT NULL,
    profile_picture character varying(500) DEFAULT ''::character varying,
    password character varying(300) NOT NULL,
    role public.user_roles DEFAULT 'regular'::public.user_roles NOT NULL
);
    DROP TABLE public.users;
       public         heap    postgres    false    638    638            �            1259    25202    users_id_seq    SEQUENCE     �   CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE public.users_id_seq;
       public          postgres    false    211                       0    0    users_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;
          public          postgres    false    212            O           2604    25204    categories id    DEFAULT     n   ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);
 <   ALTER TABLE public.categories ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    201    200            Q           2604    25205    challenges id    DEFAULT     n   ALTER TABLE ONLY public.challenges ALTER COLUMN id SET DEFAULT nextval('public.challenges_id_seq'::regclass);
 <   ALTER TABLE public.challenges ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    203    202            S           2604    25206    challenges_solved id    DEFAULT     |   ALTER TABLE ONLY public.challenges_solved ALTER COLUMN id SET DEFAULT nextval('public.challenges_solved_id_seq'::regclass);
 C   ALTER TABLE public.challenges_solved ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    205    204            T           2604    25207    tests id    DEFAULT     d   ALTER TABLE ONLY public.tests ALTER COLUMN id SET DEFAULT nextval('public.tests_id_seq'::regclass);
 7   ALTER TABLE public.tests ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    208    206            U           2604    25208 	   topics id    DEFAULT     f   ALTER TABLE ONLY public.topics ALTER COLUMN id SET DEFAULT nextval('public.topics_id_seq'::regclass);
 8   ALTER TABLE public.topics ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    210    209            X           2604    25209    users id    DEFAULT     d   ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
 7   ALTER TABLE public.users ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    212    211            �          0    25151 
   categories 
   TABLE DATA           5   COPY public.categories (id, title, icon) FROM stdin;
    public          postgres    false    200   6A       �          0    25159 
   challenges 
   TABLE DATA           c   COPY public.challenges (id, topic_id, title, difficulty_level, heading, function_name) FROM stdin;
    public          postgres    false    202   �A       �          0    25168    challenges_solved 
   TABLE DATA           P   COPY public.challenges_solved (id, user_id, challenge_id, try_date) FROM stdin;
    public          postgres    false    204   =X       �          0    25174    tests 
   TABLE DATA           P   COPY public.tests (id, input_values, expected_result, id_challenge) FROM stdin;
    public          postgres    false    206   ZX       �          0    25186    topics 
   TABLE DATA           �   COPY public.topics (id, title, icon, category_id, introduction, introduction_image, lesson_data, visualization_data) FROM stdin;
    public          postgres    false    209   �`       �          0    25194    users 
   TABLE DATA           Q   COPY public.users (id, name, email, profile_picture, password, role) FROM stdin;
    public          postgres    false    211   |�       	           0    0    categories_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.categories_id_seq', 3, true);
          public          postgres    false    201            
           0    0    challenges_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.challenges_id_seq', 70, true);
          public          postgres    false    203                       0    0    challenges_solved_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.challenges_solved_id_seq', 1, false);
          public          postgres    false    205                       0    0    tests_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.tests_id_seq', 213, true);
          public          postgres    false    208                       0    0    topics_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.topics_id_seq', 164, true);
          public          postgres    false    210                       0    0    users_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.users_id_seq', 1, true);
          public          postgres    false    212            Z           2606    25217    categories categories_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
       public            postgres    false    200            \           2606    25219    challenges challenges_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.challenges
    ADD CONSTRAINT challenges_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.challenges DROP CONSTRAINT challenges_pkey;
       public            postgres    false    202            ^           2606    25221 (   challenges_solved challenges_solved_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.challenges_solved
    ADD CONSTRAINT challenges_solved_pkey PRIMARY KEY (id);
 R   ALTER TABLE ONLY public.challenges_solved DROP CONSTRAINT challenges_solved_pkey;
       public            postgres    false    204            `           2606    25223    tests tests_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.tests DROP CONSTRAINT tests_pkey;
       public            postgres    false    206            b           2606    25225    topics topics_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.topics DROP CONSTRAINT topics_pkey;
       public            postgres    false    209            d           2606    25227    topics topics_title_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_title_key UNIQUE (title);
 A   ALTER TABLE ONLY public.topics DROP CONSTRAINT topics_title_key;
       public            postgres    false    209            f           2606    25229    users users_email_key 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);
 ?   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_key;
       public            postgres    false    211            h           2606    25231    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            postgres    false    211            j           2606    25232 5   challenges_solved challenges_solved_challenge_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.challenges_solved
    ADD CONSTRAINT challenges_solved_challenge_id_fkey FOREIGN KEY (challenge_id) REFERENCES public.challenges(id) ON DELETE CASCADE;
 _   ALTER TABLE ONLY public.challenges_solved DROP CONSTRAINT challenges_solved_challenge_id_fkey;
       public          postgres    false    204    202    2908            k           2606    25237 0   challenges_solved challenges_solved_user_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.challenges_solved
    ADD CONSTRAINT challenges_solved_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public.challenges_solved DROP CONSTRAINT challenges_solved_user_id_fkey;
       public          postgres    false    204    211    2920            i           2606    25242 #   challenges challenges_topic_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.challenges
    ADD CONSTRAINT challenges_topic_id_fkey FOREIGN KEY (topic_id) REFERENCES public.topics(id) ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.challenges DROP CONSTRAINT challenges_topic_id_fkey;
       public          postgres    false    2914    202    209            l           2606    25247    tests tests_id_challenge_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.tests
    ADD CONSTRAINT tests_id_challenge_fkey FOREIGN KEY (id_challenge) REFERENCES public.challenges(id) ON DELETE CASCADE;
 G   ALTER TABLE ONLY public.tests DROP CONSTRAINT tests_id_challenge_fkey;
       public          postgres    false    2908    206    202            m           2606    25252    topics topics_category_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE CASCADE;
 H   ALTER TABLE ONLY public.topics DROP CONSTRAINT topics_category_id_fkey;
       public          postgres    false    209    2906    200            �   �   x�U�=�@����W�E�nn��8TG��.Ԡ��$A���I;��>3�/����`����i�l�P�����FM�d�D�:��7#������ϳ���n�hX���#t�#g�1���{��2�      �      x��\M��ƙ>��#4�P	�3Uf�䑜(e)*k��x��0T�@�j S�R����'l>��Vn��������h|�C.e��v�����������t�4U+�I-t�NJ�<K
'��ĭLs=Hdq7x�H|"�N�i��'Y��w�<������C��r%�\���!���#�+%��cY��o/�o�D�JTQ-3�(��r0/�2�Q�0�1|�	�6?�8Y�Lzউu���H�
��Vɒ6�D�'��H|��b���F���o�L�%Q�7���  T��(��x$��.t��Jq]e���338IܸNV�m����'�U��J�U�k�H��M�Z��#�1��#7�\\N�"�?ӡ�]�A��M8�d���q�P����h�sL�(,0KjL$���	���LE���'� �Q��4O.����4��pc	�S#�ɭșIϑ�>�
�i+$�:|z��]��J����L�r �<��_F�?3�@ C n:�	�������0�����5H�6,�^�=P��H��`$ţEYR�y��#&n1OaF�e���mr�_���)"�$YW�03Y�W2ma�g�f�����u����x�8+Q�D^��x(^�Cq-�"��JS�k ��v��Бh��y?R!}Ӂi�0�eq��67�y'Z}��v�e�� �S�j%��m`AN@Ob�Ɖ8�fuK��A���.�ZV�T��ɶ�ķc'E�x>��d�н����H^�1Z#�m&� �Gj(n��@
eg��:?w�� s��%� nFd���K}i�6�V*�Ie%�-F�����ƃ��ʃ0d��kൎР���݁�7�� �_��!��+����"�8���(7?	�MD��rK�!� �a5��
$o�q�J�U��o+p�Q\O'�k�G����5_��i�Y2'���{���A�{4V�'s����!$�����8�H����6�;gs��a��iN���{��l0��+�����˵*�k9��8��
����s�a���O�xyR���� U���e��"����-n�b((&�����Θ E9"���%�sE��xM�h�w�B����2i�{�*�{^��1���6=�'�kSߝSԾF�p�'Ǫ&�TK�G�/:#C��'!���gD�,�gj)�
y��~�/����µ.S�&  Jd�x-��5���h�m��F������c��-�pB�?��E�v���~k��.f�&�C�i���?3�{R7��r��4�a��eB��3C�\��rv�=��i@z����&l d������AR$m�� �6��U��ᚿ�688$��!L[��Q����1'���1��n9��j�?�$+�հ^Č���a\� 4C�֞�~r�yp�'`����d�o$���	�j��*8�rKxO�dWF(7R0����H���XHl������2l�F�n~@`AC���2X���>XU>�O��#�YE�y���yhx�~Q��򒉽���G[u>�1[����6r:�� !p-�M�9��S3E�]�'�g~��l	i�b�����O0k�
ƫ�V�I�gr�Ѯ��Ca�ٻ��N��x03$�.���w�%����bd��iÔ	KJ��I�4��ϒ<o11�$��b%A�%E�NeK]%����'�x�+U۽�'��L�Cv'V2%�P��Mhb)����	��_�R����Q���Ƞ�:LASc�a��ͯ��	/8�{
�S��"�
���m�6�tY�,��F�����bh���𠖿�'.�4�_�	E���.R`����=Ӡ��݅��r+=�� ������Z�p�X��R���@����ꜲheV<�`X�,ɛ�2�K�
Εˉ){\��a9�($�fk0�5����w@q�k܃+���*���<mH%� L)q� �N���)$�Rlk;���9Q���]�9��b�.s�G��b�)
)�sV4/Ұ��[�9
�gO߭SI��p�]b�7�\����g$����$&<+���R�t�;[\�Y)����>����������1�3�1�g�n��7��IV�w0l/e�q�F�A3�V+�+�yӃ��=`��+��P�	�NEJ�\�$��C3���-A_�CŻ�Q���hP/Læ��z����"y/�O�WWm��E^{C�nm�mE��rdK4:E⪊} �L�6#�:��b�����J��v0���{��P`��%#�ݧH�4+�"�_��i��F�R��k�w `�Y�F�s3{�Q[�ca+g�S�z��t6�L�5�qEV���X����Dv�\G�k8Nr�+0�n�* �n�!�Xî��g�kE���C�$�;�q%^�z9�i�W�@a�� �ҞF���,�qf�%�gr\\H*��OO�vpT/b�%�%d�5�����X՝��:lvW`c#lZa7�p��6���tNg�wg���"���<E����&�A��i��������G��W�qyN����=��;�
�E�f�1���L]S�]��X���D!�2��*o7-���d	������C� ���J��y3�:�O�ș����D9$Q�;�c=:���Y?2�Bk�#��qc �$������"_aa��(�u#�8<�`zBw4��F�S����6�����7)"��^@ѫ��ɻ2���:���	EQ���>�]f��G�Y:����G�F�DE�.v�:k��H�_��
���!�p	�e�([��=�H�E�E��>&lՠ�4�%��@r�Q�����N�+{"�xs��G��S�UxT���m��p�)��=U-�^�qSH�l���h��` ����r��x�$�(kb]*�y+v#����ﳗ�� /$ix\'&�v1�ؐ��?�PAk��R�r��Ҥ&}!�p�����q��P�[��{G������8����wD��Z]� �����f��B�Ž,�A��n��<kZ�V?����M�!�ڸ�k.R+��p�����w�
����;=Znw7doג�{����[YRG+>\�0ϙ|R<o�%Ϻ��MGL��郠E�����
��w��&�y�Ū��#����7T�^$[�B	��p`��Ky^."�P��F�E�0g����\M/��*�n�^@�E1��\��6�BR=9|Ytv\b��[1tr��H�#S��OM�y�`�9�:>$�Qْ�m�q�u˒N��w����x�u��&Ts� ����根�`6&�^US��ȗ{����Rǟx�eoyȬ�ĭң�q����Q]1��ԩ�KҎ�ZT����L�v�*I�u�^LD��u�0�p��a������ڽ*�>��R'H�N�ră���q���A8�ل��{9F��y������aA
���+e�ZXMp��	y�ȸ��p`�C�� �1	�|K���	?���!X�Ė�qA�e�����H<�`]N��#;�ndR���1����2[�#�T��K@��Ȫu�N7A2s,Jk!K�f
e�=^��(�e����u��8D�5HGUZ�Msko�sZ*t���x� ��Gi��vX>�6�:�F[F��k��f�`N�:��Ȱ���-Ajq�ۼ��x@\ALqE���{�^�l�s�#,��:4{�D+�D����BG���R�AU�d�

��X���w|պ��sB?�c��71�W�:-����\m��p0���P��u��Oz�������|�L� �ތL��z�����ے4�g1���慰\�ЯV���%P���8�/����a�U��)��1F�[�w^A�T�]Һ�x'������{++ě�fS�x�R�e�u{Ц�1`�ޘ'b�}��l�ZF��_+R[҅�<�a�|4{?��=j��@4�	h��}�DD��xk'�m� �?�Mn�ٌ���:��u"���_��%���Y�}��°P��v��}>�y���� � ����kTt��ӻ�=G���Ύm��i0�@_n~�x����Z��,��OeM���� �z��$�^��� b  V�N;X6�xy{l�c*�9�W�2���T�޷�-�*s��]��o[kuD��yh�x�z�`Z�����y��7y\D��Ρ2�[�}t���yL�ﬗ&SƗK;��"^��.�#�*�����.���yt�섄k�FH�L�\}ۏ��vK������ٷ��nѺ3=p�VlnZ�`hnL�rb;��dY���)`�c��,��n_H�gFL��c��R�������Y|QJ�y���u�K�Ҳk4��#9&%���r�¤�X`����[����PE}᧴��\!�J�h�(A2�>�T��H�O�T�M�;���A������Q���Χ��M-j0������s�#��w�c�Ÿ ��&E�Cui�м�J�.�=5���L�����n�g�6��9��`vF�w!W*�mC��n�q�S���шw(K��"��iz��L�lI)�E]��D6���V�z&U�=�(I��[�W����*��x��^����=݄T	Q�\�z1�K+Vr�c�)S��u���o��Ǵ���R��pǥ��\^��o�ᙟP+��� ��L�7e�$�sv5���1������j%�M�{N���d�_J��k�n���Z�V�S�{E5y�����/
3r�+f̈́�-�ۗ��{�_Y܃ӻ'#�#�o��G8W ��8��<GtȔ@ٌ�t�;�����Dnc�R���t{��N?�TE�)Bb��mC(��;&q�5���T�5�^;�;�mPL;���¦��ߜc�{�nz5g,�ϥ�af�D=���`2?<��1��J��U�}�w'ܫ(�3̫^zV���h��+�޻+!|���|J|���G'\W(`�������[G�ԙ:�f.\���ÞH/�`j�/�;#�hkF�`>���,�U��f��i�f//jmȺ�O��<c��xw�����:�O0������f�Wj�|�uz;��Fw%�g�6ƕn�07^<r4F�1��kO���@XYAUkQ����z_K����%��t�i-.�c
`>�5����$������d2��"�!߿�H�miΘ���Pϵ4�s-��W=�c\5q����h�QY��j�{Ak�b������h!`']c�0��/��F�.\�o)d�j���;�;���I��ZNmT���x�D�+x�5�p1Irr���K���ӎ�t�Nƞ�]�s�Ս<@���6�_�w;3�L��Z�J�~&�ЛOp���`-�]�C�%γ��s���-�������a��f����-�Lk�==�����_�,��\6�.U'��t.rz��KJ}fG�����f�Nf������'��O��_r���|�/��	�������%~=�!8�R�q��������D_��q��|�R'�k������ūQ��
vV�.�z�?Ua�N����ϻ�g�����_��)��	����}�yQ~�����.��;���+�x-����R��nL����i�q�6�kb���KK��k��ͺ�]��yn^��ڱ\lÜ�J;���~��(R���WB������S���|2�v�QĒ��.i,8inz�Z�l=^�����턩�0s����p�љ���GA��-      �      x������ � �      �   '  x��Y�n�H}��"�s��{I����(vC��`�~y-�d9�]�v$�"�7�}8��c|z���G�s,t���ݮ[	l�	jM�� 2��>=:BE1%�+���X��p���vp��`�Ά�YDfj$<	����LBnD.����(�\_�v�m��
j��������U�n��
|�k�L[0w ]p�퀆?.Fx��ʏ~|�/�H8�l�������� �x��G�51�r��H�Y������Q"�O[��  �|\��2�#b���AF���j�OjW�N0���^�C�۸f�C�e���Z-�k;Wl�6��ψp�2ǻ��.����L2��5�t�w�,��t_˵�\���f�{�/)�H��
�/�͏>����"��F��$���Ց~������Vy+�y+��B�]3#��@U�Er#����%�e�q�1���:4����R�R��	"?�1V:���H"7���I���~�ZjkL���G:o�7*�!�QyE��I�~�n�,������g�Fqϔ'���u�cL�/�.��#�!�Y�3���(E1�嬠���&*,�c�[�U�J���Kg��!�P��Y��^���l� ���	-���u�_ 3#�G\�q�	��.�ObTzˡ�����y��,�|tt.�0=Y�`s�hd&�]Yg䢬��@�&f�휕8
���]Xg�Ѝn0�S�� \e��0�3���1��~
0%��Vq'X+Gldl��`dd�du�cc-��Y/��J9Ct��
l�%���?4��n{E�b�B���R�3~��Š��I�Y��K�Hjl�����ͨ�V��Ӹ�d��.�Nb �I����R.�i�ܨ��Ω�Z�XS�pr��U9#ۊ��.�kO�gMM�55_�"d�(U]y��gL�3L���R��R�˪�>ӕ�&<j(!@GѶxE�:0a�5o���s�����i�SH�o��%�Iʕ��ie(E�@��F�,Umܩ��{��i~������ɗ ������_�_�c�����#�}�PvB%�8�H��r��Տ���3o��zZk�~�G����ԏ+HG�O'��@:���W{�?"�b�Q�i�ǝ����5�m�@$ ���N!'G�<�p5�۰X��
�I��&�n7е�<�c�{f�Ba�4�P�jDZ"��腗�4\�\���0�5dŷ+�?���<B��{98rl��y_C��y�<�����/����?��7�h2�\!u�|H��P"�BWz�!��k+T�����	��4`�̴V�����,Ѱ��!�D�IzG�;) �>���f)�\8C����i�*�z���`	4_c�@u���y��*,�������!��im�{p�F[�����n��8�����IV�L
ωh�8�Z�z#�PZ8+}��§ �bH�	���t�l��܎�:]A;��p�h�rR�RZ��\D��9����N�[%j�@[pB����9E��[ c����??_��?��_��B0s��1�E�<~���9W���ܼ	��=T����ĺ��:Mo�
�D1����|�Sq$��L��_�Oe��r��/	��p���I�BEI��[p��C|��/D�F�ߚV✸)W��:�9��]2Z�hU�Av��Ht����_Â�w�q�_C+Wx�����h	_�0.�<Ԥ�/ކ�oD�h�mD�q~�tX�
����n�o���3҈�<�,0� *�Ϋ�
T�7*t�7��B�tAJ\��7Z�X<���s��U(}��Q�C��������o�
�����"�X��s�ЛB#���l�* R�g���X�Je[T6���B�T\+��y�9���i�u��c�I~�p���?���^^�afb��	U�,��m:�|�َ��p�.�k��^.��0��D��0�_>�,~����R��E	���caa[y�x�r}L����DUQ�@lV�����^���`�Z��	^F� ���T�ľ⤰s4�6����<�	�D��	�4T�ݦ)#?	8i�(l�Nx�쫗<k.��K�.W�]��B������;�/�      �      x��}ɎW��Z�a��Y���!'e��$�t!���[hF�`#�10�4T?�mt/��B�nߕ7�oROr���d�ʍn�J�I�p�����O�'�>�F�}}���?��!���?-����|�y�$���|{�^�޳�K�l�b���0���ЋSo�E�0K��<�pzc��3�)/̋2�T��d�_����"/PE�{KOţ4��)������.Vp�0J��/��n�'�/E8U���:J���Fi�Q^�^�x��}6��,����0)�$��i�M�2��e�L�(P�W�A��P0�B�����Sy����W^�|N��u_U&�.��VE��O����X�B%�!�2.�!,�^�F���{�ݫ��6�TI�⒏� ��G���"�W�鬀�/e��,wU�
��򆸱0z���Y⸣܇����e�Na%a��fZ��~f8__�i�wo\��a�S��������i;�^L����v4U��]��T�y�{��;::<j�igޙu�&�,>/����"ߛ�F�~�?H�2������8T������	MF�1��(MT|������ N�3����i\N�����Ng�!ՠ�����4NG;�.|�e�����HK.��V?�6��7%p��f�Ӛe��f�7Pl�R�|X����"�Y�{�O��s���e���_�����c�F����y�'x�(G
ɀ�ghY������ՖhH��w>my���߶��.=�I:E"�_������=z�_�hw`�Z��8�C��E���V�-L�9\a��q�1���
����pX�F?�C� �QB�!��z�Q���c�z��9�#\�,�0�p�sg�������G�2���ׯ̢ј�	L�v��a>�y�q�󒅩_�k����,p�=�c��Ѽ&Id��㰀3��&���C�f�N����E 7�3�Ϝ�,���p�_W:k�2�K�*��yπs"˛��ϊ�K��r�������<�g8�!*�;�4."N0'ڄ;���Y����,��U��1��pO�C"/ }�4+��A���<�,�
χ%F��+x
�7ʀ<`�y�Ki��.� i���+�<*J�X���	�0�K��*�{�;���5�L��
�>��HOp�ODc���d4f��t��p\s�3�9�G�O9�ʙ3� I�L��0CN"�D��Deum��P���y��b�D��֘cu�u�Y�!�����׷P ��i6&B
�;�N�ϒ�g6���NήG���<h>l@�O�����RZ��a�!�P�0��D1֖%fነ�'�'L�#)Qz���8N ���'��V����P ^�������(��3��A,Wi�wFT���;� m��vY(�Q�N�1lVz��,}X��g��$A`É����o�&�z�'��v<�<���iz-���$F�|�-ʍ��e)\l�%���4oϚ����y�xdރO��C���	!fj
�%�UQK���4y\Ρ���D��	𒊾4-�q�D}5D�f�8��0���`���M�d�2)��3�]�z�$a\>���,������%�� єK�T���|�P�G~�7W5vPQ����b����� (-&�QY�K�p�U%��^}R��N�d@��"
I�D�0.������%	~X�|��>�M&Y!2�M
WN8���1�&B���EB�@9bj���2�}j��&�0 �;-,��L��T(`{RG3��b8��bHx1k]��<���S���E�a���'m�j�����ԋ�VE�1��(U����8��f�Se���
3�=���NTjz�n0��D�T��	j�(Nk�#��7�'@t9�HᖸV��?��8��E�.΃���z<�\k����-�JV?�ً$��z��6�y�NB�S�L���a�iAe�k�,C�n�z$�j�Ee1��q� Eno%���d�P�_v.�ht1�..�+�<�FR�"L���,��!T,��6ߨ��nX0�=��O4S���*[�hjX22�4���[��a{0Y��Ʌ�,S���/3��{�������w�1�r^�l湿���c�^Niw�%#7�{��)!1 ���HM>��-��^��J��iB��%��F�"������H�x�HVNKELr`���%	�I)cu�H�����Q�*EfE�b]Y��O�<���r1�D���9EH��hZ1�7F=Ϋw �X1gcNy��`��V�d�#C_} ������0J�չ��"���ã���y�܏����e���/�H�PH�y�b�����'�G�T	�������p�>hy>:�/�8ƟO�l���)��n��8,��������hy:*5(��y�;r���\��Q܉Â4��c�T~���2���|����=����7ޣG�<�M�R�r�{�<��ݳ��K��O잞:��5�����):3�U�=�z�P)z�5� ��؂Vq��Q4��f�t�T�{��t�RdsI�(�x��`��D�%�^�k4�Xh���*��Z�R4.�NG�iÉ��y�Fp]?��ܠ����_5q� j.�Q,�^�^X���X��E�\I�������C�M*����"ȑa�hΐf�,�^\!uE��	�o(��FR_���N����-��t���hX���h7O�U���q��{ �!!�.\]�#�%�)����l�EAM��d�Ep�&�ځz�ʕ�#*���JZ�k��#�V�d��ʐ�&��eQ��މE���xG*�����"�O#�m�4l/Ij�c-�Y9M��/�k��lg�G�еRA����AƏ�+�$�����:E�+$8���ޣ
..�1h#�tF����4c�UmMxo�!k�aYcX�צ�a[wZ�F��R�*cg1[�Xy��q�˄�C�A�z��|5�w	$+�H%*?E�DYDR�s�"�ZS��� h��+����
��3)����X-�X}��-�q�~T��䥀{DEh�ݍ��@�g�⭫��KrF�;.���b�0�E˕�vi��-�+"Fk�AwGR�y�I� ��EA`=_�����ҏǵN�	�V����H�!�M��n{��{�:��]��"}.�5t�R?�����r&9�[��q�򼼺�0�l���AˁFU`�1ˣ�N޻P�<��ݲ|��	�:��D�����c������*t«}����pGcۉ�Q��i���CwwZ���[>q\g�>A�Q�SzxΛcv�W��(F@n��Eb�9�u�)�����tﳫn�a�lD��a�_gR	��|�|��kE�Ӓ�M`"9i���%Z�8c����-q|�'�!�v$��Š4���|�������Տ E*b�5Px����n�G4T�S8+�[vc�!����7�/a�g�b��W�!Cd�ㅙH
�1E���8QF��s��jh>su��MX�f��v��V!�5�6Z	�<�~B� ex�*�6	T2�hP�ţ)t�ԋ��M�GY��@"-�g�p����ܭ>��5��q0G�K�P�%��>B�Z;Θ'6�8A�7�R��dA�t��0�Q��T4,XCH��XA"�G��8�h�*�Zs+�;`E˙�o@S0�:2�h.��4�^�&��k5������J����b����'���kl�f�d�f�P��*���M,��<J4��T��+;������I�ܾȦ��x�_��Yty���Q4�=vW�f>F�Dfŀ9��RqeJӅ��no�z����$\F�p��N��y��wn�r�f�����7���a��`ڼ��-��Mb����0G��z	 f����H���A� Q���;E�N���.k��qk��[$�N{t4���ҁ
��gar֭�V:D�Bx��rwdM^���<���G����2^�I�����l��N/�~����p�k���-*Z��<��.\\�/�ޖuS��d�DA65���#�/�g�I����e #�dA�m�b���(!��`�8���l��! 4�\5?��%�-�^���q�κU�K,�    ,�x��|��D���Dm�������.2BQ�i�� #���r��oO�4cux�OΣ� �烳�zTHC�� kN4���	����&E{����=��҄p��l'�.�*�[��|/�ئG`�_x����N=���h�q(��&e��hao�5�3~�s.we����M�`��G{��t�����!���΃Zܻ�y����)]�G��q��z�����eHW_�ؕ�{�ط�	g��xZY*�~Z�|	���`�$� �c�����q`J8�M�������m:�Q��ϣQ��M]�m͞wc�H��T����#�n��iu[=��F�.0�Da������^��:h��0�l�����x���ˌu�&G
��T��M?�=mp��k�ɭ��R�G}g�*o�x�<zdY�F!{�KF�e�K��O�EW�]�;�L͡��Z�9��J�QV�vBG��@k�K�݈�95�ac&Ћ���n���f�##�V�W�������ݛ0v�XKQ�03�ch��iM��=���$''AW�Gqk�G&��� l��tF%�,�&�۬���5&��*�bq#��=t�U�UѴ�K�յe��z���5����"����i�@��g�C�
���
�.Qr�g�̫�8y��lCQ`���p�KV<�0!)�E�ƤO0�#M�a±��,<���HA$<��܅"�nFF�V�x�A�m���2h4�G����E��i��B ���?�$��t(�N�&�=��9�S9���ȃC�G���B(R�ޮ+��_�nw��G���2�_��ż���e�H�R�=W�h (O�:~���fҧ$�B���{< �?.��D%>�GFy��0�d�����3�oD��Ϯ�?>���i�v��)N�bE�A��k���������k �4�pe9����kx�e4[q=EG1Ǥ⦙��<��o��cD?�C��g��̒2Q�\��s�S�ƈ���me�O���Ȣ�s ��}��'�c�V�p/�VE���;`���ԡe9Ҙ��5���g��8���X�k�+�c%O0/	Į��!�qZ�^	�$M%ݏ��v:'��:(��bv'g��b�Y��-�aP���#���t5cԮ�~\r��T�_�8S(٫���$�A���,+(��"\)������u�#w��C�%h���܁o)e���K9;k\�h�`hi�a?��e  ��?Å��P��a%��g}+�y.���SH?���\Y�0q`�J
�2�v'r�ƚ�s^�e�%,��.oͷb�1�Q��"�(�@��|?(�-�!k�.r�t0B�j�z����1�Pr��c�3�t�H�?�89���aPY��a��#;2�܄4�*�R�.��N�I���m�1q�X7w�%t�&�VP)_�8���F-w�Q�9Ah���w����<Ey2/������_�o\�� ��T !m�gc�I���%I�����x��|ќ0��&���KY;@{[
��;G��|��������0����y�j����{u���%G�u,������E���m�6�����VM���t0	9���s�l�0����RtG�U=�`)��& ��oİS�����@�`��҉JG��_h���oF��&,өhg-��P<BPO����B�^���W5�k�:Z�j��%��;�����v�����b6,.��h'��!�)����0@q�%/!X6�x~)��Rt�C��"�T�<
�b��^�!	���^RƱ��Ϝ�Z��
���^�Q*�a�fħ��}�uN��[����u7d��u�mTǘ��EW3LB^�/�Q�ȗ��="��:�������V�����Pe��f���Jt+跟�Wk��n*��op��<IH&��Q�&�qo�%��W�������:�ߞn�?���״���P�ƨ��f��6���%͒�����2�l�X{�.��Ơ�;�fKm4!�$4��_��i�g���[Аp��EC��7!"���y��BG�;�y�["�-��KL�F}%$_k�z$�h�����NDn�J~I�E���`�7Y��L�"D���xy=���VE�HHq<�a���F����B��^@`��Hр+��&��!c�T�T����(i�֐T",�CS�16�}`�l������GȆ`$�g���Q�,
'�4��O�R����V����9��tP����Fh޾}��������(�O��~�����d���š���qA���&�t��Z�YR����:Dtr�j�IQ��U=��I��[�T�Ur�F��7g)k_�zIZ� �2�� rۺY4�J�>2Ui��]�;%/��|�����|�M�B���.F��]�,�%g��LS�,p����pk�1��<�l]�4
�+�&��wtϣ��
���j��QJ��^�]*6g�^�J�ܮ�#�~�Z�
_x\�w��uA(fN6+>�{�B�i|F�����	��eAZ�,�����&��jS!����9p���%���!����H��j]q��}��U>ՎMZ�\{?�U[if[�����ْ�R��p�5�Ej�0���,z:���q���^���a�/�|6BY�L��Sj ������M��$��}��@Õ��,�T��x�l|��\Q�	K�J�'|�Q�zL��%㕴��0K�߸JN=V��,)�y��+��NJ���s�N<C�D�e\(B�]��SEX�js���4��\j��	~���J�&C��머��9�FL�%���Ɂ뤙��F��B�ά�r�]~�p�{����sg�>�m������Y���Y�YL2v�q���{�:J{��x�Q)�/"�qm/�8Wy�x崁Q�ê�^�z/��s��H'e���c�Ue��|�U�Ю�����D�PGD���p�
hSQ/�d,2[nB,�K��l�j@�vPi���Q�U힂�:��d�ݽ6,(���^{v�L�GcХ�Y��A2
`�w^RC+�/!�4G�nBd�s�C-k@�A���i| ���"��G�<�5���U�'�E�N�gm|T*i|��v�O�1�Y����`;8-=���t��,���BƇ�8��|��͓���O	�u��II71��kOݽ���.>�}�uRw�~�<QY:&���W��AS�̷N|k�4��J�V	�0yA�xT!�+Ѻ��UnDJ7=|��xmL���������j�뚋N�w���8�r 37gU�!���nTI�����(:�ĠqA�ޥ.�S�1ph{)Z�9���U6��vs<=�U���'z�Zn&`q�Rv}R����s���C���K��������Z�B��3�7�*�n�_�8g�r���>�x�~G�յlP̜"D�*��Cju�dGy�afJK$�#?Q��n�.�t`�&A�q�9v��w�xP9���,�-�^	�肼M�""}F1����\\��!`����I.��]Zc�ܘ����z<-J�^�`mb�Hņr<�uf�i� 筋��<S`P���Ö�o�Ө�WFgnY���O�xVz��1��p�X�W�Z��}T�mty�s���f��y8�PY�9�2��o�����u�c[�^�4�9���빎��%%��� 1��gvy7��s8ܱԗ�Ł�75]��0���-��_a3����v�1&S�{��-h���@  �2���k�S��K\�X�DR~�Rne�^��n4����L�ض�0�Y���Z[�W����`T-����El4��(�����:Ķt,=$WR�d��(�$g�F����06z��ے#��с�^��ОN"Ӄ��Z����&��b��7��w���#�vB	��PP1r�p:���ܧ�tyA��-�tJi��� ���kn��1�:sbJE/������$�4|%pk�XT��̷u��b�ג�uuu��a�x�g{��>Z�t���4-��(n9���PҼ�t���^�=���r8L����2����ŵ�Ϫֻ�vh�$�;��ۤi��frqx9    oS�D��^_���LI�.q7TB�in���G���,�Et��.�l
j�8޺���u�����ˍ�~���'u�׾[+I���ڃ�d�����l�X���2��F���q�:$���W��۪�K�=궇Ix6H���"�͏��rЯ4!��'G�1|�&�0U�Y��N���>ǂ��9��-:P��=I(����R�s���t�_�B��������
������Q�*�"�o��8�8%.�hJ`��IN��v\����' W�:.��������6cȺ���H<r�M%0��9�HN<$һ�I�:���~�=_�N��r|4��a����V�D�$���믚��+�K���l��l�04Z+]�CCr5O��	���,7&X�1v��K�ꍫmļ��\sr�I�y7\�u�u��G�_�Kba�2�S΍�|���D��U��k�s�zH�5Od�]���`��)�^��*t䞛_��@q�Հ��S����im@^����XZ�����0`7U]j�%k�2��Cr�F��5��VVؙ�K��Ĳ��ޜJ*N�4g�N�ע80��ֱ"ud��w�?:֮N��r`�J�F���(��I(B���bL���O�������ny�\ۂ1+
��bSTiE��<�#[0������&����X���JR��VȨצ����,=�ɫo[R�6��p��V�����n��#���9�kJ���{[)�#��������w���lݦk1r�[Vr�^�_ ��3�#�J�OSwX�K8{ ��&i���O�7���l]�WX3��簣��R�Z.��>���`��y�������0��l<����xZ.&��n�z%+O�;���N���[������%'HK7��
���Ju�)�Ϊ&�B����G�Ԅ�zD�K�~�Qp���_���|l����an�D)��~�+�M��Vn��a�=/��y�/U�W���dwC�Gڀv��_�>�E���}l�&�9i�Y?��/����D���l6�ҩ��:i��M(�ds3d󆸥-��j��G�$�����oiO:���n��0�g�p49�tgY�OnWs�iO�����YLe"�1�m�MW�8�E�����WqS��mn�����A�?����Z�� N��(hƫ��W��N���V��R�.7+��Lc�;��ڲ۶�s�u���:��nM.� F�OM��U�*�Z��g��"�=��= uS˛�ރFZK<ѳ���2�;<��Qj#�"�Y��ȥ(pR�kN�$�Dr�*%����-H��5-B��0��i�����G�ɌE���wE����O�mT��E�I�rD}0���9�nP���,�[��Y�M���j�-���sZ�ס��1��q��U�ǝ1[�<֦���fp��(���`��ά��W�����܄�s3��p�k]{C�NywA��Ӻ W�}@�R8�}��8��{�y;�0]O��"lh�q�J��h�3�~�t�!a�2$�R����{�����D���v��#L���:��\ޜC�^�+�4����\ڦfkX+6I��K��ݲՇMW8�F%�3�tl=-PWk�D���ET�G'K�6Ɲ��t,��وc.��P=A��L�(��)k�(��C��BOp��}[���:��D<͢3pC#�P�r�j�n9y����LS<X�4��O��>N͓͕��t�e̋)VL����k^ΨbI��X�\#̎+���S�6������h8;7�\u�>p���iZ#�qm��8�-�����_���*~����{n�����`l���VN�wD]�3�/�{TQmqfe���ֱ.�I��N�R����_i얊�
��fx�2i��&a����,��p����e re8�����*����ŕ�Ei�'T�X-{ݭ��p`��M��фBv������Շ=��-��e��\���@��ݡ1�����?�� �����Q���拃��䬛��١O�A�E���>@b��:ʸ)c��q�ZL�NsVC��xs�8���-������6޼c*YO͞m���^1�\P����[kV�=�"@���	ڧ�*bBWkΧ)��d�У��U�	z4�;�� BR(.�bW��J�=�uE�1��d-VV�����%�I�`ў�\vOe ztL-f����~RC[I�H�՘���V�i(d#CkцQ2G8]�ET2�h����"�O*R��+���v��RdI��uA3�\�V?t8a���qu0�x�"6�~�~�봼.K�S`��4�N�rn�Bɤ�y9�sh�)� ���-��N��=l��"Β���bty~V��&�x���^'B�R�כ�4�e�\6e�NlfuFy)�i��[�jI,��9��6­�A���u�R]53�m-_���=Ɏ�$�?�U��Xf��wx~��}��J�R�B��+�����S���s���ok���I�=���e�/�bT��A:��nwJ	Ya�*4R�;�~�*0,'q;Q޳��S1���+a�z���0� o�G<N�ٕf�]�X�q7I�-����a��^��A��ˋ�8�4R�.�;��e�����7��y����y��#��J��b�&��;�pʯ�:e�W��@ctf]�)���Rn�+�MK;�`����R�Jۜ������.3�#���brs"���9s%,^HK��Jg���c���@C<a���d�ՇJ�ȼ�P���v��[}x�;=Xc���a��I�dwC�����f��V")�Q�4|I�D�j1n��`�4�u�-O_�V����"�`�����C��˰��wo꯫����/zLG�괈����j|�U*�;��'��u�حO�~�`Ja�#� ��G�BǸj���)w�dX���G:%e�O5��қ���P8g��<����9xu1�q�*��#a��՞&������=���^������M�7�!�[��y�v��FZy���tE��]uE��+�x��UW��k�w��)�0�P��~��;��RW#�%pwQ�&���	�%A����dZ[�~DׇO�NH+e*!'p��:�?������_���:�=��Ɣ��g�C���Ԉ�y ��_��7o�g~�u/o�P�m� g�������M�>ė�����8����:����;��g�<p_H_n���T&d�J{��V*�9ػ#�� XE�$i��Дa\rY��5CY�+���o�E���%=�%�T�s}�j�X�9��ǁ��(	vL��<膌��C���Wj��k�c-�Z|9�aU�v������]V0%]2[@o�	p��GD�E����]�ktў2Dxԡ0��O�e��@CO�m�� �o	�.��e���N��0]��*�)Jć�UV�"����H{��m��ǷZ�D��D+��%G��b�(`�1�\2�hE]L��etZ�/�5yrAw݀@��LTjt��e�~,�,����Y-�X#ҿ�8��;�@4���'
�]��#K&ք�x��v�=.SJ������Ҽ$�CS{cM���6��''�@��:.'����2Yz�x�Mqqg�C��K�=TZ<�dQ�`�,��h�S뼢�T� �G<�A���KBA�ыa94���c�� �k�`�d�Z\��ߌ� ;�~�rj\�I�Z�����(���T�#�:�d}���6���ڑ�dnx�x��$E�@}h���~Z����(G�X��Տ���\�27p�YU���vgJ�nz��t��T�k��{���M��<ԣZ�ܡX�������`!��mQl#�gH�T0I�2�rIB���������Tn��.G�_Q�(������jTqqkaN$�*ـ9���5�{��<�t�E,h���ʹ�Y������_�S�p�g�t��%|�{�����^�/��~��:�x���DY4���9R$L�#�RT;p�¡*jkWJ��	&� ��e�7/+�����{����0K��4�-$��<Jn�p�p3S�+g�[%�)�H��Ǖe\��f�z�;�:_�V�Mͫ�dY}����ӎ��A7�]�g#?���5`����c����Sf'V8����@�kE     �c��w��u��)G]�W=��_dDn2��NH���z	g�:�D�1�FA&��'����	�Ǡ�D�:�NP7(h�2�A�ʂ:k�7�I�5"vc�I�E�7�@�S+�LsK�V)���H�]!|9!�_����L�'� {����(L��IrgE���6ʌ-�\�ЁX
EL�ǀ�;G)w���n;/�G�Gg����|<??��͎o_}(t��J\��9�;ӧ;�V�-1f5�աtxӚѹ��7�^
����:Qz�'t�r�o��AG�v�}]?~����\���O�~����^��j�ݜ�n����o�V�O�C��:���yH-�� *��W�]�֋��
���e��8�<D7�n�u�{nQ/|�@����H ��ڽ�5߸�&F������>�:��3�O	?	겔��K��;�N摴�sh ����O	�+163��Y���U�O-q�f�m�`�`��Z�A�;�?�.|���'��	|��{{{{�N�x¾rR?V�tz��۶�4g��A-��_�&��MjK_� � ���3 �<D��p�ӫ����O�[53y ;���" �������f���W�K��"�Bk�p���Y�_�\i}}��� F|��
"��a3��d㛉��_uAw�����B�����.]^��� �H��9t�E��� ��hĀ"�Æ�?��z�&[��h�'����k�
-�Y��0�zVR������J1o���\EE�]����≨R��gR������ETa�7�*�$����&=���h���Y����aS�ds�<����?�֒��&���
tl�0ġ�ȼ�c��up3���E8��]p��Vs�vdV���M�S*��w*f��#��	c�� ��e�~�tPZK)�R�dy����)�3�"�)�R#T߰���Fo�d0$��H;F�!= ѻ@�3��,����T쓎c"����?�)`�DSX'�	SF~�p��d�MU��ġy5��W?f�q�V�!am]������s��	��b��R_��f�����p�OY���j�3���A]���<��å���^����n���	!X���¢ƤȊ$'��h&�M�R*_8�=��*@����gZ���[�|ᐡK�Z�E�	H�S΀tލ.R,��q�o��	���՞	��=34���$?s>+���O�*,�RE��N:&�k��N$y,���Bŝ���?J���"%��'h�{[r#�y:n7��
�:�Hn��������������nd��S��V�;����Ce�p��J��o�2{c]f)	��-sv�r��ڒo�ض����4<B�	˕�5�d�q���(Ō��@q�4�1I�I������a榴���X��U��s�\ U1��%���)�aT7«����Ss�$���)�ŵYZ��R�B�l�CȂ�TE�5�o�J{��M�$%�j��`��r��A�#1J8$V����@C�!U4o�F��t����+�I��[F�G�)`������q�˟���e���1�[���1�iS�ťa	v�P�s�vO�y_�Ar���B����F��	���]�'�Y�H�x�4Li9ҩ�#�1�L��Y�:>�GfF�*�GR��ͫ��x���©>�i��Wߙ�=��W�谳�o�'�"�,Ԥ;�E��ó�3A��k����%��0Df�6�r�hfyڴ�=�����9�=SY����R�/r,:��ٜ>�BgW̸��J[
�i���	R�+'n�{Ue��>�!lO�����<���2���A;�/C#̵��z�`*\M�Y�͊ռN��%"�������Ś��>�)L=�z{6\���X�T[ڕB��t�CYb�Q� �܊R�F0E~���?�[i�5�T<T<���+3`��̄F�$/ݧ�Jgw�������¡�l��r��w���M�"ZG�|����0)vˢ��DG��B��"�^������l-P3g�$N��|�٢�Y?�yV�>�f�qX#$���I��q��N��8Q��8����Ѡ7��~��k�2?/�A9QJ�bx�v�Z�rI�(��q�7N�F�4�M�nӘ��q��~7����6�eT�����(?GKC��gA���Q�^�A�V�����#�h��m���7B��Pa^Wiv�3x��n�]ηq%��?����S�2C�J�tҵ-�p����3j1��(/
�"k/�v�x�Dah)��y���M�.U�	{��?��	ыS[wY��9�F�I����=T�9�8Mnu����x����X=��qyp����?�|QW����Ni�k�K�F�[:��$�$�8�f��%�
"I)��n�ԁ�报9Q��(x�+4� �簞G��צ�����Q�5�?���m��P�\7Ζ~
���`��$)
meF�A'��O�CR����4�J�H�0]�Е@�S�8�9t�-:��� �h6��DՙLZ��{7��	H�[���F���L觖I>����y/GV�D��.�K��tV�U*7N��J�l������d�>Ȟ��ӣK�+�͕��i��&a^a8f8��2��LeY�}�*P9�ȝ�&�^��#����f��
f�n�lȤ�ߺr�J��+���*�l�]5}v����O��U�����\�n,�,���PcF[���u�"����x�'H&��Zh�����i�3J9��p�j����l����f��9[ܮ�@��l&����@��$�5���\0_���Y90�8� ��s6��FU�:;�/:�0�f���4$�-����b�p�z_E>L?z������U+�ŜrH��hE!�z/�bG���$�*���r�1䩰1��P����D_:��v+\o���¥��
h"�/���1�Xu)�tp��D�IT�ڭ��N��`���58�%�YQ>D�0nz�I`���E�Z�l\{��[��u��k%����T��f�+Ew��Iz;͋���Me�j�.\�|t���6K��N4J5L΍�0A��Ӯ��>�Vq�q�4,8lq�MOg�
qY�i$��v�-�e,A�V��id��6Ǐp���@�&)����{p�
��g��z���vrD)�u�`��O��)���_R�kĈ��8MKJ�\j��WWwe�9�z��|��h�`ݒ,�5�w$�u�r%9���Tr�%���+[�e���U�'M,�S��nZ���Z棄�T���8.��G����qϣJ�2T���د�łPQ�w\��ō/t$!���b3�k��9�\�3���K~�G�:��)fWYάN3�fT������u�����
�m��D�\8F�`�
V��P�rF<O:u@���������sm�[�z�������O��<�/gӣ��^s��t�J&-#k��&�f׹IwvJ ~\;�~U�)�7]��m����w:��t6�̒��Iz��_L����ܤ��f����.}t��ډ����=���`Y�X�5�˟�/�[R$�� t�tQ�
C��I���(P�W*G��$U�J��YT�vr��J*�I:c�oD��(��{��o=���*�S���r�����	o�弊[�����^�=J���(g��eYz����@g^���3�uO�?Z��=���˕p%}��{�@G�T�VG�BN��>Z{��ލ��;XqL�]�m�`�E�Ŋ0^���Rm�!'��Ƀ"�qj�r�?�nYeH��>I0
��2������� 8�"cp�N��)�ң춝Gd�a�F(\�<6KҪO�jo�Q{U�N*�;[T���7w�&�w �oV�dM�=,�(��@��.�_�3��B:\f�Ԧ�V��$�� ���{6X�����y�U�A�g��A��hv{g��`��lS�����}qu�}K�V����Կ��4�~�t;0��?�@WJ���W{�����Ռo�֑vb��{վ���4U� ���i�|�&Ծ�Tj�p��򵛞����nLb�7b�7#RJS�R惋b/%���Ao�&��fڰM�y������n�[���Q1��
��ڍS�(�%�+6=��S~
!�*d�Q�������b��,��\ �  �<|����߼�Br8;-���]`P����Il�Ѫ��Խk���U;!��ƆS��&�V��ӱ�\4?�.���79�$���1��K	�V�j��F؊��b &c�}�N�Y�U!�%"LOI��<������i�I��_Gl�˴7[��mI�!�ܩ�]o��15a�=v���I@IF��(�R�n�0�XՄ	�X�J�68nyZ�'��W�}ц���6�}���q3�ws#ڿ����tT�|�ḑ�`C����%r8�؉V��&��W|jZ�O�B1�q����Q���rM��gT�-����{_k�5T��'�Ě+1�#mݺ��g�= |L���4@��gQ������cq7� �\H���n/�Q�wI`n���^}�V9}��7b������N���L@S�'	��>z܁��ŚՕW�]w ���(0@L�D�L��lv1Em_�f�'7WX٣E�R�2��H|^��	�z�^�|m�����[���/zRd1f��j����A���Hb��p�<��q�F|�d6��[T<��o.��@�{��,�O�a�NcH1�n�5��Oi�M	�+���J�u��܄�T2�t�N��oݽ�� ���N�$�@Qn�P�$�RKI8��5	ē,]�Lر�n0% �����H�-�TW��^嶎˞�9)�&��y�u��Z�*����q@���щS3'H�>���^n��{ݽ��	&,��	�w�rl���f<�j�G�	{r�����B�`���L$�DL��e���.��)6#[��KI3�-�	����ԕp�-C``�:��`N��ξk0���SYr�y����w���+��09����7�������O���F�:�� 6��zP6���D'��`����WR���=XG�`�<-�t�`n��)��TH���ʩG`�\Um�Cv|�.>�j%�E(���A��0)��`4���b4I��Z/Ce�)w E�1�ݝ�c�ѮK-����N5�s�V��k�`�������xI[d%�����"�D&�ߠ���=��oX��m��q�}�/�2K�~�|~��ER^���ҭAjj\�:Q�PR�t��ϼ�F���{ʚ�-2�P��6���a{�$_�."5*�� ]��6Ʀ��Ҹ�Q]��.��d�+s|����P���3Gg˳;R��;�6��U�9��oquN��l_��brv.�Yq2���Y�3���o~����bG      �   j   x�3��LN,J��,��鹉�9z�����*FI*�*N�&ii��%�>A�Qi����ɦ>U.a�)Y�E%%F����N&����E��9�E\1z\\\ �� Z     