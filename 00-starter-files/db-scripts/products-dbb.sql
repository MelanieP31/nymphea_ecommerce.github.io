-- -----------------------------------------------------
-- Schema full-stack-ecommerce
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `full-stack-ecommerce`;

CREATE SCHEMA `full-stack-ecommerce`;
USE `full-stack-ecommerce` ;

-- -----------------------------------------------------
-- Table `full-stack-ecommerce`.`product_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `full-stack-ecommerce`.`product_category` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE=InnoDB
AUTO_INCREMENT = 1;

-- -----------------------------------------------------
-- Table `full-stack-ecommerce`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `full-stack-ecommerce`.`product` (
  `id` BIGINT(20) NOT NULL AUTO_INCREMENT,
  `sku` VARCHAR(255) DEFAULT NULL,
  `name` VARCHAR(255) DEFAULT NULL,
  `subname`VARCHAR(255) DEFAULT NULL,
  `introduction` VARCHAR(500) DEFAULT NULL,
  `description` VARCHAR(5000) DEFAULT NULL,
  `application_type` VARCHAR(250) DEFAULT NULL,
  `unit_price` DECIMAL(13,2) DEFAULT NULL,
  `image_url` VARCHAR(255) DEFAULT NULL,
  `ingredients` VARCHAR(1000) DEFAULT NULL,
  `active` BIT DEFAULT 1,
  `units_in_stock` INT(11) DEFAULT NULL,
   `date_created` DATETIME(6) DEFAULT NULL,
  `last_updated` DATETIME(6) DEFAULT NULL,
  `category_id` BIGINT(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_category` (`category_id`),
  CONSTRAINT `fk_category` FOREIGN KEY (`category_id`) REFERENCES `product_category` (`id`)
) 
ENGINE=InnoDB
AUTO_INCREMENT = 1;


-- -----------------------------------------------------
-- Add sample data
-- -----------------------------------------------------

INSERT INTO PRODUCT_CATEGORY(CATEGORY_NAME) VALUES ('Savon');
INSERT INTO PRODUCT_CATEGORY(CATEGORY_NAME) VALUES ('Exfoliant');
INSERT INTO PRODUCT_CATEGORY(CATEGORY_NAME) VALUES ('Shampoing');
INSERT INTO PRODUCT_CATEGORY(CATEGORY_NAME) VALUES ('Crème');
INSERT INTO PRODUCT_CATEGORY(CATEGORY_NAME) VALUES ('Autres');

INSERT INTO PRODUCT (SKU, name, subname, introduction, description, application_type, unit_price, image_url, ingredients, active, units_in_stock, date_created, category_id)
VALUES ('SOAP-1000', 'Le Nourrissant', 'Savon amande douce et miel',
'Notre savon le plus nourrissant, avec du beurre de karité, du beurre de cacao et de l''huile d''amande douce, sans huile essentiel', 
'Notre savon amande douce et miel est le plus nourrissant de notre gamme. Contenant du beurre de karité et du beurre de cacao, il est idéal pour les peaux sèches, abimées ou encore déshydratées. Ces beurres contiennent de nombreux acide gras qui contribuent à hydraté, apaisé et nourrir la peau. L''huile d''amand douce est largement utilisé pour son action apaisante et adoucissante sur les peaux délicate. Pour compléter notre recette, le miel, lui, a des vertus antiseptique, adoucissante et apaisante. Il absorbe les impurtés qui obstruent les pores et agit comme un nettoyant pour laisser une une peau propre, hydrater et éclatante. Sans huile essentiel ce savon est parfait pour les peaux les délicates et toute la famille.',
'Peau sensible et sèche', 8.99, 'assets/images/products/placeholder1.png',
'huile d''olive(), huile de coco(), huile d''amande douce(), beurre de karité(), beurre de cacao(), miel(), fragrance Body Butter().',
,1,100,NOW(),1);

INSERT INTO PRODUCT (SKU, name, subname, introduction, description, application_type, unit_price, image_url, ingredients, active, units_in_stock, date_created, category_id)
VALUES ('SOAP-1001', 'Le Bonne-mine', 'Savon carotte et agrumes',
'Un savon parfait pour assimiler le soleil, plein de vitamine et d''antioxydant pour protéger votre peau',
'Un savon enrichi en macérat de carotte, riche en beta-carotène qui améliore le teint et prépare la peau au bronzage. Plein d''antioxydant, il protège la peau des effets veillissant du soleil et permet de prévenir l''apparition de ridules. Composé de beurre de karité pour nourrir la peau et la garder hydrater toute la journée. Ce savon contient aussi de l''huile essentiel d''orange et citron aux vertus purifiante pour la peau. Elles aident à équilibrer la production de sébum, revitalise et tonifie la peau, laissant une sensation de fraicheur et de vitalité.',
'Tout type de peau', 8.99, 'assets/images/products/placeholder2.png',
'huile d''olive(), huile de coco(), beurre de karité(), macérat de carotte(), huile essentiel d''orange(), huile essentiel de citron().',
,1,100,NOW(),1);

INSERT INTO PRODUCT (SKU, name, subname, introduction, description, application_type, unit_price, image_url, ingredients, active, units_in_stock, date_created, category_id)
VALUES ('SOAP-1002', 'Le Purifiant', 'Savon au charbon',
'Un savon au charbon actif permettant de purifier, nettoyer et réguler le sébum de votre peau.', 
'Un savon qui détoxifie, désincruste les pores et nettoie en profondeur la peau, grâce au charbon actif. In le désseche pas la peau grâce au beurre de karité qui la nourrit en profondeur. Avec un peu d''huile essentiel d''eucalyptus qui a des propriétés assainissante permettant de réguler la production de sébum et de laisser une sensation de fraicheursur la peau. Compléter avec de l''huile essentiel de cèdre de l''Atlas a l''odeur boisée relaxante. Ce savon peut être utilisé sur toutes les peaux et convient parfaitement au peau mixte à tendance grasse.',
'Peau normal à grasse', 8.99, 'assets/images/products/placeholder3.png',
'huile d''olive(), huile de coco(), beurre de karité(), huile de ricin(), charbon actif(), huile essentiel eucalyptus(), huile essentiel de cèdre de l''Atlas()',
,1,100,NOW(),1);

INSERT INTO PRODUCT (SKU, name, subname, introduction, description, application_type, unit_price, image_url, ingredients, active, units_in_stock, date_created, category_id)
VALUES ('SOAP-1003', 'Le Anti-acnée', 'Savon au chanvre et romarin',
'Un savon régulateur de sébum, au propriété anti-inflammatoire et antispetique spécialement concu pour lutter contre l''acnée.', 
'Ce savon est enrichi en huile de chanvre connue pour ses nombreux bienfaits pour tout type de peau. Grâca a sa teneur élevée en matiere grasses, elle nourrit pronfondémment et est hydratante pour les peaux sèche, tout en équilibrant la production de sébum, un avantage pour les peaux à tendance grasse. Pour les peaux à tendance acnéique, en plus de régulerle sébum, cette huile permet d''apaiser les rougeurs, les irritations cutannée et à des propriétées anti-bactériennes. Enfin, elle peut favoriser le renouvellement cellulaire et ainsi améliorer la cicatrisation ds petites plaies laisser par les boutons d''acnée. Ce savon est aussi compléter par trois huiles essentiels connu dans le traitement de l''acnée. L''huile essentiel d''arbre à thé, de palamrosa et de romarin qui ont des propriété antibactérienne, anti-inflammatoire et antiseptique : des effets assainissant permettant la lutte contre l''apparition des boutons.',
'Peau grasse, à imperfection', 8.99, 'assets/images/products/placeholder1.png',
'huile d''olive(), huile de coco(), huile de ricin(), huile de chanvre(), huile essentiel d''arbre à thé(), huile essentiel de romarin(), huile essentiel de palamarosa(), argile verte().',
,1,100,NOW(),1);

INSERT INTO PRODUCT (SKU, name, subname, introduction, description, application_type, unit_price, image_url, ingredients, active, units_in_stock, date_created, category_id)
VALUES ('SOAP-1004', 'Le Madame', 'Savon à l''argan et rose de Damas',
'Un savon hydratant et à la bonne odeur de rose pour lutter contre les signes de l''âge et hydrater en profondeur les peaux matures.', 
'L''huile d''argan présent dans ce savon contient de puissant anti-oxydant et vitamines permettant de diminuer l''apparition des rides et ridules, de nourrir la peau en profondeur et de renforcer son éléasticité. Cette huile est donc souvant utilisé en tant qu''hydratant et dans les soins anti-age. Parfaite pour les peaux mature ainsi que pour les peaux sèche. Notre savon à l''huile d''argan est aussi compléter par de l''huile essentiel de rose de Dams. Elle est connue pour son action anti-âge et vivifainate mais aide aussi a am"liorer l''élasticité et la qualité de la peau, et ) régénérer et tonifier les peaux fatigués. De plus sa douce odeur envoutante vous ravira! Ce savon bien que convenant à tout type de peau, est particulièrment indiquer pour les peaux mature.',
'Peau mature', 8.99, 'assets/images/products/placeholder2.png',
'huile d''olive(), huile de coco(), huile de ricin(), huile d''argan(), huile essentiel de rose de Damas().',
,1,100,NOW(),1);

INSERT INTO PRODUCT (SKU, name, subname, introduction, description, application_type, unit_price, image_url, ingredients, active, units_in_stock, date_created, category_id)
VALUES ('SOAP-1005', 'Le Tout-doux', 'Savon au lait de chèvre et géranium',
'Notre savon le plus doux pour les peaux délicate en recherche d''hydratation.', 
'Le Savon de chèvre au lait de ch-vre est concu pour hydrater en douceur les peaux sensible. le lait de chèvre est riche en hydratant naturel et en vitamine. L''acide lactique, lui conférent une action exfoliante permettant de nettoyant en profondeur et de laisser une peau douce. Ce savon est compléter avec de l''huile essentiel de géranium qui a des propriété tonique , utiliser pour éliminer les impruté mais aussi pour resserer les pores de la peaux donnant de l''éclat au teint.',
'Peau normal à sensible', 8.99, 'assets/images/products/placeholder3.png',
'huile d''olive(), huile de coco(), huile de ricin(), lait de chèvre(), huile essentiel de géranium().',
,1,100,NOW(),1);

INSERT INTO PRODUCT (SKU, name, subname, introduction, description, application_type, unit_price, image_url, ingredients, active, units_in_stock, date_created, category_id)
VALUES ('EXF-2000', 'Amande-café', 'Exfoliant à l''amande douce et café',
'Un exfoliant doux, moussant, nourrissant en profondeur, et ne laissant aucune rougeur. Parfait pour exfolier les peaux les plus sensible', 
'Un exfoliant contenant beaucoup de beurre de karité et de beurre de cacao pour nourrir la peaux en profondeur, ainsi que de l''huile d''amande douce pour adoucir votre peau. Les graines exfoliante sont de la marc de café, un des exfoliants les plus doux qui soit !',
'Peau sensible', 8.99, 'assets/images/products/placeholder1.png',
'huile d''olive(), huile de coco(), beurre de karité(), beurre de cacao(), huile d''amande douce(), miel, marc de café().',
,1,100,NOW(),2);

INSERT INTO PRODUCT (SKU, name, subname, introduction, description, application_type, unit_price, image_url, ingredients, active, units_in_stock, date_created, category_id)
VALUES ('EXF-2001', 'Soleil', 'Exfoliant Carotte, agrumes et abricot',
'Un exfoliant puissant ', 
'Un exfoliant préparant votre peau au bronzage et au soleil ! Contenant du macérat de carottes pour assimilimer les rayons du soleil mais aussi pleins d''anti-oxydant pour la protéger des effets néfastes de celui-ci vous voila prete pour votre sortie plage. L''agent exfoliant : de la poudre de noyaux d''abricot, puissant permet d''exfolier votre peau pour qu''elles soient toute douce et propre! ',
'Tout type de peau', 8.99, 'assets/images/products/placeholder1.png',
'huile d''olive(), huile de coco(), huile de ricin(), huile de chanvre(), huile essentiel d''arbre à thé(), huile essentiel de romarin(), huile essentiel de palamarosa(), argile verte().',
,1,100,NOW(),2);

INSERT INTO PRODUCT (SKU, name, subname, introduction, description, application_type, unit_price, image_url, ingredients, active, units_in_stock, date_created, category_id)
VALUES ('SHAMP-3000', 'Shampoing1', 'Shampoing cheveux gras',
'Un shampoing.', 
'S',
'Cheveux gras', 8.99, 'assets/images/products/placeholder1.png',
'huile d''olive(), huile de coco().',
,1,100,NOW(),3);

INSERT INTO PRODUCT (SKU, name, subname, introduction, description, application_type, unit_price, image_url, ingredients, active, units_in_stock, date_created, category_id)
VALUES ('SHAMP-3001', 'Shampoing2', 'Shampoing cheveux sec',
'Un shampoing.', 
'S',
'Cheveux sec', 8.99, 'assets/images/products/placeholder1.png',
'huile d''olive(), huile de coco().',
,1,100,NOW(),3);

INSERT INTO PRODUCT (SKU, name, subname, introduction, description, application_type, unit_price, image_url, ingredients, active, units_in_stock, date_created, category_id)
VALUES ('CREM-4000', 'L''hydratante', 'Creme à l''Aloe Vera',
'Une creme.', 
'C',
'Cheveux gras', 8.99, 'assets/images/products/placeholder1.png',
'huile d''olive(), huile de coco().',
,1,100,NOW(),4);

INSERT INTO PRODUCT (SKU, name, subname, introduction, description, unit_price, image_url, ingredients, active, units_in_stock, date_created, category_id)
VALUES ('AUT-5000', 'Belle lèvre', 'Baume à lèvre',
'Un baume spéciale hiver, anti levre gerser.', 
'C',
8.99, 'assets/images/products/placeholder1.png',
'huile d''olive(), huile de coco().',
,1,100,NOW(),5);


