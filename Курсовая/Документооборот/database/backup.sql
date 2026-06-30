PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_migrations" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "app" varchar(255) NOT NULL, "name" varchar(255) NOT NULL, "applied" datetime NOT NULL);
INSERT INTO django_migrations VALUES(1,'contenttypes','0001_initial','2026-05-04 22:07:32.435725');
INSERT INTO django_migrations VALUES(2,'auth','0001_initial','2026-05-04 22:07:32.590363');
INSERT INTO django_migrations VALUES(3,'admin','0001_initial','2026-05-04 22:07:32.624377');
INSERT INTO django_migrations VALUES(4,'admin','0002_logentry_remove_auto_add','2026-05-04 22:07:32.657923');
INSERT INTO django_migrations VALUES(5,'admin','0003_logentry_add_action_flag_choices','2026-05-04 22:07:32.686751');
INSERT INTO django_migrations VALUES(6,'contenttypes','0002_remove_content_type_name','2026-05-04 22:07:32.733517');
INSERT INTO django_migrations VALUES(7,'auth','0002_alter_permission_name_max_length','2026-05-04 22:07:32.773930');
INSERT INTO django_migrations VALUES(8,'auth','0003_alter_user_email_max_length','2026-05-04 22:07:32.794679');
INSERT INTO django_migrations VALUES(9,'auth','0004_alter_user_username_opts','2026-05-04 22:07:32.823225');
INSERT INTO django_migrations VALUES(10,'auth','0005_alter_user_last_login_null','2026-05-04 22:07:32.844195');
INSERT INTO django_migrations VALUES(11,'auth','0006_require_contenttypes_0002','2026-05-04 22:07:32.859016');
INSERT INTO django_migrations VALUES(12,'auth','0007_alter_validators_add_error_messages','2026-05-04 22:07:32.909577');
INSERT INTO django_migrations VALUES(13,'auth','0008_alter_user_username_max_length','2026-05-04 22:07:32.930053');
INSERT INTO django_migrations VALUES(14,'auth','0009_alter_user_last_name_max_length','2026-05-04 22:07:32.962050');
INSERT INTO django_migrations VALUES(15,'auth','0010_alter_group_name_max_length','2026-05-04 22:07:32.994542');
INSERT INTO django_migrations VALUES(16,'auth','0011_update_proxy_permissions','2026-05-04 22:07:33.008794');
INSERT INTO django_migrations VALUES(17,'auth','0012_alter_user_first_name_max_length','2026-05-04 22:07:33.032105');
INSERT INTO django_migrations VALUES(18,'sessions','0001_initial','2026-05-04 22:07:33.054276');
INSERT INTO django_migrations VALUES(19,'accounts','0001_initial','2026-05-04 22:16:57.207636');
INSERT INTO django_migrations VALUES(20,'templates_app','0001_initial','2026-05-04 22:31:26.330477');
INSERT INTO django_migrations VALUES(21,'documents','0001_initial','2026-05-04 22:39:26.573591');
INSERT INTO django_migrations VALUES(22,'documents','0002_remove_generateddocument_file_type','2026-05-04 23:04:36.436199');
INSERT INTO django_migrations VALUES(23,'templates_app','0002_remove_documenttemplate_file_type','2026-05-04 23:04:36.471592');
INSERT INTO django_migrations VALUES(24,'documents','0003_practicedata_fio_genitive','2026-05-09 17:30:02.975787');
INSERT INTO django_migrations VALUES(25,'accounts','0002_profile_fio_genitive','2026-05-12 19:11:28.277046');
INSERT INTO django_migrations VALUES(26,'documents','0004_triggerlog','2026-05-13 18:17:37.696182');
INSERT INTO django_migrations VALUES(27,'documents','0005_create_database_triggers','2026-05-13 18:45:47.261426');
CREATE TABLE IF NOT EXISTS "auth_group_permissions" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "group_id" integer NOT NULL REFERENCES "auth_group" ("id") DEFERRABLE INITIALLY DEFERRED, "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "auth_user_groups" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "group_id" integer NOT NULL REFERENCES "auth_group" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "permission_id" integer NOT NULL REFERENCES "auth_permission" ("id") DEFERRABLE INITIALLY DEFERRED);
CREATE TABLE IF NOT EXISTS "django_admin_log" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "object_id" text NULL, "object_repr" varchar(200) NOT NULL, "action_flag" smallint unsigned NOT NULL CHECK ("action_flag" >= 0), "change_message" text NOT NULL, "content_type_id" integer NULL REFERENCES "django_content_type" ("id") DEFERRABLE INITIALLY DEFERRED, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "action_time" datetime NOT NULL);
INSERT INTO django_admin_log VALUES(1,'1','Характеристика УП — study',1,'[{"added": {}}]',8,1,'2026-05-04 23:12:43.156965');
INSERT INTO django_admin_log VALUES(2,'2','Характеристика ПП — production',1,'[{"added": {}}]',8,1,'2026-05-04 23:13:12.303214');
INSERT INTO django_admin_log VALUES(3,'3','Аттестационный лист УП — study',1,'[{"added": {}}]',8,1,'2026-05-04 23:13:34.019386');
INSERT INTO django_admin_log VALUES(4,'4','Аттестационный лист ПП — production',1,'[{"added": {}}]',8,1,'2026-05-04 23:13:49.213770');
INSERT INTO django_admin_log VALUES(5,'2','Иванов Егор Игоревич',3,'',7,1,'2026-05-05 00:03:37.217868');
INSERT INTO django_admin_log VALUES(6,'2','egor',3,'',4,1,'2026-05-05 00:04:33.489912');
INSERT INTO django_admin_log VALUES(7,'5','Аттестационный лист УП — study',1,'[{"added": {}}]',8,1,'2026-05-05 01:22:08.280354');
INSERT INTO django_admin_log VALUES(8,'6','Kirill',3,'',4,1,'2026-05-12 18:12:26.666325');
INSERT INTO django_admin_log VALUES(9,'4','Nikita',3,'',4,1,'2026-05-12 18:12:26.666395');
INSERT INTO django_admin_log VALUES(10,'5','asd',3,'',4,1,'2026-05-12 18:12:26.666415');
INSERT INTO django_admin_log VALUES(11,'3','egor',3,'',4,1,'2026-05-12 18:12:26.666430');
INSERT INTO django_admin_log VALUES(12,'5','Аттестационный лист УП — study',3,'',8,1,'2026-05-12 18:14:41.632084');
CREATE TABLE IF NOT EXISTS "django_content_type" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "app_label" varchar(100) NOT NULL, "model" varchar(100) NOT NULL);
INSERT INTO django_content_type VALUES(1,'admin','logentry');
INSERT INTO django_content_type VALUES(2,'auth','permission');
INSERT INTO django_content_type VALUES(3,'auth','group');
INSERT INTO django_content_type VALUES(4,'auth','user');
INSERT INTO django_content_type VALUES(5,'contenttypes','contenttype');
INSERT INTO django_content_type VALUES(6,'sessions','session');
INSERT INTO django_content_type VALUES(7,'accounts','profile');
INSERT INTO django_content_type VALUES(8,'templates_app','documenttemplate');
INSERT INTO django_content_type VALUES(9,'documents','practicedata');
INSERT INTO django_content_type VALUES(10,'documents','generateddocument');
INSERT INTO django_content_type VALUES(11,'documents','triggerlog');
CREATE TABLE IF NOT EXISTS "auth_permission" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "content_type_id" integer NOT NULL REFERENCES "django_content_type" ("id") DEFERRABLE INITIALLY DEFERRED, "codename" varchar(100) NOT NULL, "name" varchar(255) NOT NULL);
INSERT INTO auth_permission VALUES(1,1,'add_logentry','Can add log entry');
INSERT INTO auth_permission VALUES(2,1,'change_logentry','Can change log entry');
INSERT INTO auth_permission VALUES(3,1,'delete_logentry','Can delete log entry');
INSERT INTO auth_permission VALUES(4,1,'view_logentry','Can view log entry');
INSERT INTO auth_permission VALUES(5,2,'add_permission','Can add permission');
INSERT INTO auth_permission VALUES(6,2,'change_permission','Can change permission');
INSERT INTO auth_permission VALUES(7,2,'delete_permission','Can delete permission');
INSERT INTO auth_permission VALUES(8,2,'view_permission','Can view permission');
INSERT INTO auth_permission VALUES(9,3,'add_group','Can add group');
INSERT INTO auth_permission VALUES(10,3,'change_group','Can change group');
INSERT INTO auth_permission VALUES(11,3,'delete_group','Can delete group');
INSERT INTO auth_permission VALUES(12,3,'view_group','Can view group');
INSERT INTO auth_permission VALUES(13,4,'add_user','Can add user');
INSERT INTO auth_permission VALUES(14,4,'change_user','Can change user');
INSERT INTO auth_permission VALUES(15,4,'delete_user','Can delete user');
INSERT INTO auth_permission VALUES(16,4,'view_user','Can view user');
INSERT INTO auth_permission VALUES(17,5,'add_contenttype','Can add content type');
INSERT INTO auth_permission VALUES(18,5,'change_contenttype','Can change content type');
INSERT INTO auth_permission VALUES(19,5,'delete_contenttype','Can delete content type');
INSERT INTO auth_permission VALUES(20,5,'view_contenttype','Can view content type');
INSERT INTO auth_permission VALUES(21,6,'add_session','Can add session');
INSERT INTO auth_permission VALUES(22,6,'change_session','Can change session');
INSERT INTO auth_permission VALUES(23,6,'delete_session','Can delete session');
INSERT INTO auth_permission VALUES(24,6,'view_session','Can view session');
INSERT INTO auth_permission VALUES(25,7,'add_profile','Can add profile');
INSERT INTO auth_permission VALUES(26,7,'change_profile','Can change profile');
INSERT INTO auth_permission VALUES(27,7,'delete_profile','Can delete profile');
INSERT INTO auth_permission VALUES(28,7,'view_profile','Can view profile');
INSERT INTO auth_permission VALUES(29,8,'add_documenttemplate','Can add document template');
INSERT INTO auth_permission VALUES(30,8,'change_documenttemplate','Can change document template');
INSERT INTO auth_permission VALUES(31,8,'delete_documenttemplate','Can delete document template');
INSERT INTO auth_permission VALUES(32,8,'view_documenttemplate','Can view document template');
INSERT INTO auth_permission VALUES(33,9,'add_practicedata','Can add practice data');
INSERT INTO auth_permission VALUES(34,9,'change_practicedata','Can change practice data');
INSERT INTO auth_permission VALUES(35,9,'delete_practicedata','Can delete practice data');
INSERT INTO auth_permission VALUES(36,9,'view_practicedata','Can view practice data');
INSERT INTO auth_permission VALUES(37,10,'add_generateddocument','Can add generated document');
INSERT INTO auth_permission VALUES(38,10,'change_generateddocument','Can change generated document');
INSERT INTO auth_permission VALUES(39,10,'delete_generateddocument','Can delete generated document');
INSERT INTO auth_permission VALUES(40,10,'view_generateddocument','Can view generated document');
INSERT INTO auth_permission VALUES(41,11,'add_triggerlog','Can add trigger log');
INSERT INTO auth_permission VALUES(42,11,'change_triggerlog','Can change trigger log');
INSERT INTO auth_permission VALUES(43,11,'delete_triggerlog','Can delete trigger log');
INSERT INTO auth_permission VALUES(44,11,'view_triggerlog','Can view trigger log');
CREATE TABLE IF NOT EXISTS "auth_group" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(150) NOT NULL UNIQUE);
CREATE TABLE IF NOT EXISTS "auth_user" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "password" varchar(128) NOT NULL, "last_login" datetime NULL, "is_superuser" bool NOT NULL, "username" varchar(150) NOT NULL UNIQUE, "last_name" varchar(150) NOT NULL, "email" varchar(254) NOT NULL, "is_staff" bool NOT NULL, "is_active" bool NOT NULL, "date_joined" datetime NOT NULL, "first_name" varchar(150) NOT NULL);
INSERT INTO auth_user VALUES(1,'pbkdf2_sha256$1000000$SE3r32orrFWGGwOhdM9VpG$vO2YwXu54Ym26vsfRaARnYpiqw+aOfYPoBOX1Hxrl4Y=','2026-05-04 22:10:37.174518',1,'admin','','',1,1,'2026-05-04 22:10:02.146716','');
INSERT INTO auth_user VALUES(7,'pbkdf2_sha256$1000000$zCFV7o88AT6VsXYumlZLkU$uJ/bEFEp9dPI6yx7Qdr6QT4aVtBZLfh50MUa953Cq7k=',NULL,0,'egor','','',0,1,'2026-05-12 18:25:42.849502','');
INSERT INTO auth_user VALUES(8,'pbkdf2_sha256$1000000$jG4TTNl95ECjj5DVDARKDG$cp58heWtjPvWBGHvdZnAeB6KULN2HUeoy3wH0NXefw4=',NULL,0,'Nikita','','',0,1,'2026-05-12 19:45:28.483592','');
CREATE TABLE IF NOT EXISTS "django_session" ("session_key" varchar(40) NOT NULL PRIMARY KEY, "session_data" text NOT NULL, "expire_date" datetime NOT NULL);
INSERT INTO django_session VALUES('peijmbn29pyuo8lxn93h19gbyriozq8o','.eJxVjMsOwiAQRf-FtSGFIg-X7vsNZAZmpGogKe3K-O_apAvd3nPOfYkI21ri1mmJcxYXocTpd0NID6o7yHeotyZTq-syo9wVedAup5bpeT3cv4MCvXzrgUbNIRAqYE4ZMJBGS96iYj9aE4z1hiEnd4YMKTgzavDsPQ9A7Fi8PxRuOUA:1wK1Ur:pZREIus83aLJSUIQVRM6FsORb3bl-Pc4FkkmMyOTU5A','2026-05-18 22:10:37.213929');
CREATE TABLE IF NOT EXISTS "templates_app_documenttemplate" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "name" varchar(255) NOT NULL, "practice_type" varchar(20) NOT NULL, "file" varchar(100) NOT NULL, "is_active" bool NOT NULL, "uploaded_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
INSERT INTO templates_app_documenttemplate VALUES(1,'Характеристика УП','study','templates/характеристика_УП.docx',1,'2026-05-04 23:12:43.155658','2026-05-04 23:12:43.155717');
INSERT INTO templates_app_documenttemplate VALUES(2,'Характеристика ПП','production','templates/характеристика_ПП.docx',1,'2026-05-04 23:13:12.301681','2026-05-04 23:13:12.301726');
INSERT INTO templates_app_documenttemplate VALUES(3,'Аттестационный лист УП','study','templates/аттестационный_лист_УП.docx',1,'2026-05-04 23:13:34.018555','2026-05-04 23:13:34.018593');
INSERT INTO templates_app_documenttemplate VALUES(4,'Аттестационный лист ПП','production','templates/аттестационный_лист_ПП.docx',1,'2026-05-04 23:13:49.210731','2026-05-04 23:13:49.210811');
CREATE TABLE IF NOT EXISTS "documents_generateddocument" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "file" varchar(100) NOT NULL, "created_at" datetime NOT NULL, "template_id" bigint NOT NULL REFERENCES "templates_app_documenttemplate" ("id") DEFERRABLE INITIALLY DEFERRED, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "practice_data_id" bigint NOT NULL REFERENCES "documents_practicedata" ("id") DEFERRABLE INITIALLY DEFERRED);
INSERT INTO documents_generateddocument VALUES(22,'generated/document_7_ae41719484304e3eb54ea3f95a7f9f78.docx','2026-05-12 19:32:58.965716',3,7,11);
INSERT INTO documents_generateddocument VALUES(23,'generated/document_7_80f00c90220e40ddae4cb6e9fca1ed40.docx','2026-05-12 19:32:59.372612',1,7,11);
INSERT INTO documents_generateddocument VALUES(24,'generated/document_7_87451e90cbaa41ac9861ba6ab9ea4aa1.docx','2026-05-12 19:36:26.607781',3,7,12);
INSERT INTO documents_generateddocument VALUES(25,'generated/document_7_614933539cc247a5ab0029d3a257fcd1.docx','2026-05-12 19:36:26.994940',1,7,12);
INSERT INTO documents_generateddocument VALUES(26,'generated/document_7_fa9abaaa660947b8bc15aea51197bfc8.docx','2026-05-12 19:40:33.003303',3,7,13);
INSERT INTO documents_generateddocument VALUES(27,'generated/document_7_4d1bd5caf9ac4b7d94eb71ee62b4eb92.docx','2026-05-12 19:40:33.424895',1,7,13);
INSERT INTO documents_generateddocument VALUES(28,'generated/document_7_628565dac9ca4984a2cd7c2660732449.docx','2026-05-12 19:41:00.626933',4,7,14);
INSERT INTO documents_generateddocument VALUES(29,'generated/document_7_4193a82ab0564ed08ce6c27078ac1b27.docx','2026-05-12 19:41:00.798989',2,7,14);
INSERT INTO documents_generateddocument VALUES(30,'generated/document_7_da35933cf2104936ae3ddab5c758f4aa.docx','2026-05-12 19:44:34.668679',3,7,15);
INSERT INTO documents_generateddocument VALUES(31,'generated/document_7_a51fdbc72c914c29a094ee6f7e54b636.docx','2026-05-12 19:44:35.064570',1,7,15);
INSERT INTO documents_generateddocument VALUES(32,'generated/document_8_1777b28f3b844566953f436a95efd31e.docx','2026-05-12 19:46:08.560059',3,8,16);
INSERT INTO documents_generateddocument VALUES(33,'generated/document_8_9d2e42f10c8d4eca8c07047ef3c18662.docx','2026-05-12 19:46:09.033746',1,8,16);
INSERT INTO documents_generateddocument VALUES(34,'generated/document_8_106d024af4c6488487668acc5eefa5f5.docx','2026-05-12 19:46:38.678882',4,8,17);
INSERT INTO documents_generateddocument VALUES(35,'generated/document_8_f3f1d6f7b9b8430397539b266d82ac14.docx','2026-05-12 19:46:38.836442',2,8,17);
INSERT INTO documents_generateddocument VALUES(36,'generated/document_7_36a5df494ec54fb8ad7edb393539e84c.docx','2026-05-12 20:32:07.831950',4,7,18);
INSERT INTO documents_generateddocument VALUES(37,'generated/document_7_fbcf78d5727f4606a859b073fb64d1eb.docx','2026-05-12 20:32:08.112584',2,7,18);
INSERT INTO documents_generateddocument VALUES(38,'generated/document_7_59ce850abc33401cac24066ee6836fa7.docx','2026-05-13 19:11:38.291491',4,7,19);
INSERT INTO documents_generateddocument VALUES(39,'generated/document_7_562f4df88d6a4ff58c398024ef28332d.docx','2026-05-13 19:11:38.510909',2,7,19);
CREATE TABLE IF NOT EXISTS "documents_practicedata" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "fio" varchar(255) NOT NULL, "study_group" varchar(100) NOT NULL, "specialty" varchar(255) NOT NULL, "course" smallint unsigned NOT NULL CHECK ("course" >= 0), "education_form" varchar(100) NOT NULL, "practice_type" varchar(20) NOT NULL, "practice_code" varchar(255) NOT NULL, "organization" varchar(500) NOT NULL, "address" varchar(500) NOT NULL, "supervisor" varchar(255) NOT NULL, "date_begin" date NOT NULL, "date_end" date NOT NULL, "document_date" date NOT NULL, "created_at" datetime NOT NULL, "user_id" integer NOT NULL REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "fio_genitive" varchar(255) NOT NULL);
INSERT INTO documents_practicedata VALUES(11,'Иванов Егор Игоревич','ИС-24','Информационные системы и программирование',2,'очная','study','ПМ.12 Выполнение работ по одной или нескольким профессиям рабочих, должностям служащих','ГБПОУ МО «Люберецкий техникум»','Московская область, г. Люберцы','Петров Петр Петрович','2026-05-04','2026-05-31','2026-05-04','2026-05-12 19:32:58.645145',7,'Иванова Егора Игоревича');
INSERT INTO documents_practicedata VALUES(12,'Иванов Егор Игоревич','ИС-24','Информационные системы и программирование',2,'очная','study','ПМ.12 Выполнение работ по одной или нескольким профессиям рабочих, должностям служащих','ГБПОУ МО «Люберецкий техникум»','Московская область, г. Люберцы','Петров Петр Петрович','2026-05-04','2026-05-29','2026-05-04','2026-05-12 19:36:26.213649',7,'Иванова Егора Игоревича');
INSERT INTO documents_practicedata VALUES(13,'Иванов Егор Игоревич','ИС-24','Информационные системы и программирование',2,'очная','study','ПМ.12 Выполнение работ по одной или нескольким профессиям рабочих, должностям служащих','ГБПОУ МО «Люберецкий техникум»','Московская область, г. Люберцы','Петров Петр Петрович','2026-05-04','2026-05-31','2026-05-04','2026-05-12 19:40:32.666240',7,'Иванова Егора Игоревича');
INSERT INTO documents_practicedata VALUES(14,'Иванов Егор Игоревич','ИС-24','Информационные системы и программирование',2,'очная','production','ПМ.12 Выполнение работ по одной или нескольким профессиям рабочих, должностям служащих','ГБПОУ МО «Люберецкий техникум»','Московская область, г. Люберцы','Петров Петр Петрович','2026-05-04','2026-05-31','2026-05-04','2026-05-12 19:41:00.310815',7,'Иванова Егора Игоревича');
INSERT INTO documents_practicedata VALUES(15,'Иванов Егор Игоревич','ИС-24','Информационные системы и программирование',2,'очная','study','ПМ.12 Выполнение работ по одной или нескольким профессиям рабочих, должностям служащих','ГБПОУ МО «Люберецкий техникум»','Московская область, г. Люберцы','Петров Петр Петрович','2026-05-04','2026-05-31','2026-05-04','2026-05-12 19:44:34.387859',7,'Иванова Егора Игоревича');
INSERT INTO documents_practicedata VALUES(16,'Козырев Никита Алексеевич','ИС-24','Информационные системы и программирование',3,'очная','study','УП.02 Учебная практика','ГБПОУ МО «Люберецкий техникум»','Московская область, г. Люберцы','Иванова Анна Сергеевна','2026-05-04','2026-05-31','2026-05-04','2026-05-12 19:46:08.213817',8,'Козырева Никиты Алексеевича');
INSERT INTO documents_practicedata VALUES(17,'Козырев Никита Алексеевич','ИС-24','Информационные системы и программирование',4,'очная','production','ПМ.12 Выполнение работ по одной или нескольким профессиям рабочих, должностям служащих','ООО «Практика»','Московская область, г. Люберцы','Иванова Анна Сергеевна','2026-05-04','2026-05-31','2026-05-04','2026-05-12 19:46:38.377545',8,'Козырева Никиты Алексеевича');
INSERT INTO documents_practicedata VALUES(18,'Иванов Егор Игоревич','ИС-24','Информационные системы и программирование',2,'очная','production','ПМ.12 Выполнение работ по одной или нескольким профессиям рабочих, должностям служащих','ООО «Практика»','Московская область, г. Люберцы','Иванова Анна Сергеевна','2026-05-03','2026-05-02','2026-05-31','2026-05-12 20:32:07.345868',7,'Иванова Егора Игоревича');
INSERT INTO documents_practicedata VALUES(19,'Иванов Егор Игоревич','ИС-24','Информационные системы и программирование',2,'очная','production','ПП.01 Производственная практика','ООО «Практика»','Московская область, г. Люберцы','Иванова Анна Сергеевна','2026-05-11','2026-05-11','2026-05-11','2026-05-13 19:11:37.837689',7,'Иванова Егора Игоревича');
CREATE TABLE IF NOT EXISTS "accounts_profile" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "full_name" varchar(255) NOT NULL, "study_group" varchar(100) NOT NULL, "is_admin" bool NOT NULL, "user_id" integer NOT NULL UNIQUE REFERENCES "auth_user" ("id") DEFERRABLE INITIALLY DEFERRED, "fio_genitive" varchar(255) NOT NULL);
INSERT INTO accounts_profile VALUES(1,'Администратор','',1,1,'');
INSERT INTO accounts_profile VALUES(7,'Иванов Егор Игоревич','ИС-24',0,7,'');
INSERT INTO accounts_profile VALUES(8,'Козырев Никита Алексеевич','ИС-24',0,8,'Козырев Никита Алексеевич');
CREATE TABLE IF NOT EXISTS "documents_triggerlog" ("id" integer NOT NULL PRIMARY KEY AUTOINCREMENT, "event_type" varchar(20) NOT NULL, "table_name" varchar(100) NOT NULL, "row_id" integer NULL, "message" text NOT NULL, "created_at" datetime NOT NULL);
INSERT INTO documents_triggerlog VALUES(1,'INSERT','documents_practicedata',19,'Добавлены данные практики для студента: Иванов Егор Игоревич','2026-05-13 19:11:37');
INSERT INTO documents_triggerlog VALUES(2,'INSERT','documents_generateddocument',38,'Создан новый документ: generated/document_7_59ce850abc33401cac24066ee6836fa7.docx','2026-05-13 19:11:38');
INSERT INTO documents_triggerlog VALUES(3,'INSERT','documents_generateddocument',39,'Создан новый документ: generated/document_7_562f4df88d6a4ff58c398024ef28332d.docx','2026-05-13 19:11:38');
DELETE FROM sqlite_sequence;
INSERT INTO sqlite_sequence VALUES('django_migrations',27);
INSERT INTO sqlite_sequence VALUES('django_admin_log',12);
INSERT INTO sqlite_sequence VALUES('django_content_type',11);
INSERT INTO sqlite_sequence VALUES('auth_permission',44);
INSERT INTO sqlite_sequence VALUES('auth_group',0);
INSERT INTO sqlite_sequence VALUES('auth_user',8);
INSERT INTO sqlite_sequence VALUES('templates_app_documenttemplate',5);
INSERT INTO sqlite_sequence VALUES('documents_generateddocument',39);
INSERT INTO sqlite_sequence VALUES('documents_practicedata',19);
INSERT INTO sqlite_sequence VALUES('accounts_profile',8);
INSERT INTO sqlite_sequence VALUES('documents_triggerlog',3);
CREATE UNIQUE INDEX "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" ("group_id", "permission_id");
CREATE INDEX "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" ("group_id");
CREATE INDEX "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" ("permission_id");
CREATE UNIQUE INDEX "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" ("user_id", "group_id");
CREATE INDEX "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" ("user_id");
CREATE INDEX "auth_user_groups_group_id_97559544" ON "auth_user_groups" ("group_id");
CREATE UNIQUE INDEX "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" ("user_id", "permission_id");
CREATE INDEX "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" ("user_id");
CREATE INDEX "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" ("permission_id");
CREATE INDEX "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" ("content_type_id");
CREATE INDEX "django_admin_log_user_id_c564eba6" ON "django_admin_log" ("user_id");
CREATE UNIQUE INDEX "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" ("app_label", "model");
CREATE UNIQUE INDEX "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" ("content_type_id", "codename");
CREATE INDEX "auth_permission_content_type_id_2f476e4b" ON "auth_permission" ("content_type_id");
CREATE INDEX "django_session_expire_date_a5c62663" ON "django_session" ("expire_date");
CREATE INDEX "documents_generateddocument_template_id_2929174a" ON "documents_generateddocument" ("template_id");
CREATE INDEX "documents_generateddocument_user_id_3eb1b383" ON "documents_generateddocument" ("user_id");
CREATE INDEX "documents_generateddocument_practice_data_id_9c8b2f05" ON "documents_generateddocument" ("practice_data_id");
CREATE INDEX "documents_practicedata_user_id_3c428772" ON "documents_practicedata" ("user_id");
CREATE TRIGGER trg_practicedata_insert
            AFTER INSERT ON documents_practicedata
            FOR EACH ROW
            BEGIN
                INSERT INTO documents_triggerlog (
                    event_type,
                    table_name,
                    row_id,
                    message,
                    created_at
                )
                VALUES (
                    'INSERT',
                    'documents_practicedata',
                    NEW.id,
                    'Добавлены данные практики для студента: ' || NEW.fio,
                    CURRENT_TIMESTAMP
                );
            END;
CREATE TRIGGER trg_practicedata_update
            AFTER UPDATE ON documents_practicedata
            FOR EACH ROW
            BEGIN
                INSERT INTO documents_triggerlog (
                    event_type,
                    table_name,
                    row_id,
                    message,
                    created_at
                )
                VALUES (
                    'UPDATE',
                    'documents_practicedata',
                    NEW.id,
                    'Изменены данные практики для студента: ' || NEW.fio,
                    CURRENT_TIMESTAMP
                );
            END;
CREATE TRIGGER trg_generateddocument_insert
            AFTER INSERT ON documents_generateddocument
            FOR EACH ROW
            BEGIN
                INSERT INTO documents_triggerlog (
                    event_type,
                    table_name,
                    row_id,
                    message,
                    created_at
                )
                VALUES (
                    'INSERT',
                    'documents_generateddocument',
                    NEW.id,
                    'Создан новый документ: ' || NEW.file,
                    CURRENT_TIMESTAMP
                );
            END;
CREATE TRIGGER trg_template_insert
            AFTER INSERT ON templates_app_documenttemplate
            FOR EACH ROW
            BEGIN
                INSERT INTO documents_triggerlog (
                    event_type,
                    table_name,
                    row_id,
                    message,
                    created_at
                )
                VALUES (
                    'INSERT',
                    'templates_app_documenttemplate',
                    NEW.id,
                    'Загружен новый шаблон: ' || NEW.name,
                    CURRENT_TIMESTAMP
                );
            END;
CREATE TRIGGER trg_template_update
            AFTER UPDATE ON templates_app_documenttemplate
            FOR EACH ROW
            BEGIN
                INSERT INTO documents_triggerlog (
                    event_type,
                    table_name,
                    row_id,
                    message,
                    created_at
                )
                VALUES (
                    'UPDATE',
                    'templates_app_documenttemplate',
                    NEW.id,
                    'Изменён шаблон: ' || NEW.name,
                    CURRENT_TIMESTAMP
                );
            END;
CREATE TRIGGER trg_template_delete
            AFTER DELETE ON templates_app_documenttemplate
            FOR EACH ROW
            BEGIN
                INSERT INTO documents_triggerlog (
                    event_type,
                    table_name,
                    row_id,
                    message,
                    created_at
                )
                VALUES (
                    'DELETE',
                    'templates_app_documenttemplate',
                    OLD.id,
                    'Удалён шаблон: ' || OLD.name,
                    CURRENT_TIMESTAMP
                );
            END;
COMMIT;
