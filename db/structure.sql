CREATE TABLE "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "news" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar NOT NULL, "content" text NOT NULL, "channel" integer DEFAULT 0 NOT NULL, "event" integer DEFAULT 0 NOT NULL, "tag" varchar NOT NULL, "status" integer DEFAULT 0 NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_news_on_channel" ON "news" ("channel");
INSERT INTO schema_migrations (version) VALUES
('20170214045127'),
('20170221150757');


