
CREATE SEQUENCE public.compte_id_seq;

CREATE TABLE public.compte (
                id INTEGER NOT NULL DEFAULT nextval('public.compte_id_seq'),
                nom VARCHAR(20) NOT NULL,
                prenom VARCHAR(20) NOT NULL,
                adresse VARCHAR(100) NOT NULL,
                code_postale VARCHAR(5) NOT NULL,
                ville VARCHAR(30) NOT NULL,
                telephone VARCHAR(10) NOT NULL,
                mail VARCHAR(40) NOT NULL,
                mot_de_passe VARCHAR(10) NOT NULL,
                CONSTRAINT compte_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.compte_id_seq OWNED BY public.compte.id;

CREATE SEQUENCE public.statut_commande_id_seq;

CREATE TABLE public.statut_commande (
                id INTEGER NOT NULL DEFAULT nextval('public.statut_commande_id_seq'),
                statut VARCHAR(300) NOT NULL,
                CONSTRAINT statut_commande_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.statut_commande_id_seq OWNED BY public.statut_commande.id;

CREATE SEQUENCE public.produit_id_seq;

CREATE TABLE public.produit (
                id INTEGER NOT NULL DEFAULT nextval('public.produit_id_seq'),
                nom VARCHAR(20) NOT NULL,
                description VARCHAR(300) NOT NULL,
                prix_ht NUMERIC(4,2) NOT NULL,
                prix_ttc NUMERIC(4,2) NOT NULL,
                CONSTRAINT produit_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.produit_id_seq OWNED BY public.produit.id;

CREATE SEQUENCE public.panier_id_seq;

CREATE TABLE public.Panier (
                id INTEGER NOT NULL DEFAULT nextval('public.panier_id_seq'),
                prix_ht NUMERIC(4,2) NOT NULL,
                prix_ttc NUMERIC(4,2) NOT NULL,
                statut VARCHAR(20) NOT NULL,
                produit_id INTEGER NOT NULL,
                date TIMESTAMP NOT NULL,
                CONSTRAINT panier_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.panier_id_seq OWNED BY public.Panier.id;

CREATE SEQUENCE public.pizzeria_id_seq;

CREATE TABLE public.pizzeria (
                id INTEGER NOT NULL DEFAULT nextval('public.pizzeria_id_seq'),
                adresse VARCHAR(100) NOT NULL,
                code_postale VARCHAR(5) NOT NULL,
                ville VARCHAR(20) NOT NULL,
                telephone VARCHAR(10) NOT NULL,
                mail VARCHAR(40) NOT NULL,
                CONSTRAINT pizzeria_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.pizzeria_id_seq OWNED BY public.pizzeria.id;

CREATE SEQUENCE public.employe_id_seq;

CREATE TABLE public.employe (
                id INTEGER NOT NULL DEFAULT nextval('public.employe_id_seq'),
                pizzeria_id INTEGER NOT NULL,
                compte_id INTEGER NOT NULL,
                CONSTRAINT employe_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.employe_id_seq OWNED BY public.employe.id;

CREATE SEQUENCE public.commande_id_seq;

CREATE SEQUENCE public.commande_numero_commande_seq;

CREATE TABLE public.commande (
                id INTEGER NOT NULL DEFAULT nextval('public.commande_id_seq'),
                numero_commande INTEGER NOT NULL DEFAULT nextval('public.commande_numero_commande_seq'),
                pizzeria_id INTEGER NOT NULL,
                statut_commande_id INTEGER NOT NULL,
                panier_id INTEGER NOT NULL,
                CONSTRAINT commande_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.commande_id_seq OWNED BY public.commande.id;

ALTER SEQUENCE public.commande_numero_commande_seq OWNED BY public.commande.numero_commande;

CREATE SEQUENCE public.livraison_id_seq;

CREATE TABLE public.livraison (
                id INTEGER NOT NULL DEFAULT nextval('public.livraison_id_seq'),
                adresse VARCHAR(30) NOT NULL,
                commande_id INTEGER NOT NULL,
                employe_id INTEGER NOT NULL,
                CONSTRAINT livraison_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.livraison_id_seq OWNED BY public.livraison.id;

CREATE SEQUENCE public.client_id_seq;

CREATE TABLE public.client (
                id INTEGER NOT NULL DEFAULT nextval('public.client_id_seq'),
                compte_id INTEGER NOT NULL,
                livraison_id INTEGER NOT NULL,
                CONSTRAINT client_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.client_id_seq OWNED BY public.client.id;

CREATE SEQUENCE public.ingredient_id_seq;

CREATE TABLE public.ingredient (
                id INTEGER NOT NULL DEFAULT nextval('public.ingredient_id_seq'),
                nom VARCHAR(20) NOT NULL,
                quantite INTEGER NOT NULL,
                CONSTRAINT ingredient_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.ingredient_id_seq OWNED BY public.ingredient.id;

CREATE SEQUENCE public.stock_id_seq;

CREATE SEQUENCE public.stock_ingredient_id_seq;

CREATE TABLE public.stock (
                id INTEGER NOT NULL DEFAULT nextval('public.stock_id_seq'),
                ingredient_id INTEGER NOT NULL DEFAULT nextval('public.stock_ingredient_id_seq'),
                produit_id INTEGER NOT NULL,
                date_reception TIMESTAMP NOT NULL,
                date_peremption TIMESTAMP NOT NULL,
                pizzeria_id INTEGER NOT NULL,
                CONSTRAINT stock_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.stock_id_seq OWNED BY public.stock.id;

ALTER SEQUENCE public.stock_ingredient_id_seq OWNED BY public.stock.ingredient_id;

CREATE SEQUENCE public.recette_id_seq;

CREATE TABLE public.recette (
                id INTEGER NOT NULL DEFAULT nextval('public.recette_id_seq'),
                nom VARCHAR(20) NOT NULL,
                ingredient_id INTEGER NOT NULL,
                description VARCHAR(300) NOT NULL,
                produit_id INTEGER NOT NULL,
                CONSTRAINT recette_pk PRIMARY KEY (id)
);


ALTER SEQUENCE public.recette_id_seq OWNED BY public.recette.id;

ALTER TABLE public.client ADD CONSTRAINT client_compte_fk
FOREIGN KEY (compte_id)
REFERENCES public.compte (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.employe ADD CONSTRAINT compte_employe_fk
FOREIGN KEY (compte_id)
REFERENCES public.compte (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commande ADD CONSTRAINT commande_statut_commande_fk
FOREIGN KEY (statut_commande_id)
REFERENCES public.statut_commande (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.recette ADD CONSTRAINT produit_recette_fk
FOREIGN KEY (produit_id)
REFERENCES public.produit (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.stock ADD CONSTRAINT stock_produit_fk
FOREIGN KEY (produit_id)
REFERENCES public.produit (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.Panier ADD CONSTRAINT produit_panier_fk
FOREIGN KEY (produit_id)
REFERENCES public.produit (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commande ADD CONSTRAINT panier_commande_fk
FOREIGN KEY (panier_id)
REFERENCES public.Panier (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.employe ADD CONSTRAINT pizzeria_employe_fk
FOREIGN KEY (pizzeria_id)
REFERENCES public.pizzeria (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commande ADD CONSTRAINT pizzeria_commande_fk
FOREIGN KEY (pizzeria_id)
REFERENCES public.pizzeria (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.livraison ADD CONSTRAINT employe_livraison_fk
FOREIGN KEY (employe_id)
REFERENCES public.employe (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.livraison ADD CONSTRAINT commande_livraison_fk
FOREIGN KEY (commande_id)
REFERENCES public.commande (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.client ADD CONSTRAINT client_livraison_fk
FOREIGN KEY (livraison_id)
REFERENCES public.livraison (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.recette ADD CONSTRAINT ingredient_recette_fk
FOREIGN KEY (ingredient_id)
REFERENCES public.ingredient (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.stock ADD CONSTRAINT ingredient_stock_fk
FOREIGN KEY (ingredient_id)
REFERENCES public.ingredient (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
