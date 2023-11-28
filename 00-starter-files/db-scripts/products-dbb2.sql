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
'"Découvrez le savon Amande Douce et Miel, le joyau le plus nourrissant de notre collection. Enrichi en beurre de karité et en beurre de cacao, ce savon offre une solution idéale pour les peaux sèches, abîmées et déshydratées. Les acides gras présents dans ces beurres contribuent à hydrater, apaiser et nourrir la peau en profondeur.
L'huile d'amande douce, réputée pour ses propriétés apaisantes et adoucissantes sur les peaux délicates, est un ingrédient clé de notre formule. Pour compléter cette recette bienfaisante, le miel offre des vertus antiseptiques, adoucissantes et apaisantes. Il agit comme un puissant nettoyant en absorbant les impuretés qui obstruent les pores, laissant ainsi la peau propre, hydratée et éclatante.
Notre savon, dépourvu d'huiles essentielles, convient parfaitement aux peaux délicates et à toute la famille. Offrez à votre peau le soin qu'elle mérite avec notre savon Amande Douce et Miel, une expérience quotidienne de douceur et de bien-être."',
'Peau sensible et sèche', 8.99, 'assets/images/products/placeholder1.png',
'huile d''olive(), huile de coco(), huile d''amande douce(), beurre de karité(), beurre de cacao(), miel(), fragrance Body Butter().',1,100,NOW(),1);

INSERT INTO PRODUCT (SKU, name, subname, introduction, description, application_type, unit_price, image_url, ingredients, active, units_in_stock, date_created, category_id)
VALUES ('SOAP-1001', 'Le Bonne-mine', 'Savon carotte et agrumes',
'Un savon parfait pour assimiler le soleil, plein de vitamine et d''antioxydant pour protéger votre peau',
'Découvrez notre savon enrichi au macérat de carotte, une véritable merveille pour la peau. Riche en bêta-carotène, ce savon favorise un teint éclatant tout en préparant délicatement la peau au bronzage. Grâce à sa haute teneur en antioxydants, il agit comme un bouclier protecteur contre les effets vieillissants du soleil, contribuant ainsi à prévenir l'apparition des ridules.

La formule de ce savon comprend également du beurre de karité, un allié parfait pour nourrir la peau en profondeur et maintenir une hydratation optimale tout au long de la journée. Pour une expérience sensorielle revitalisante, nous avons ajouté de l'huile essentielle d'orange et de citron, reconnues pour leurs vertus purifiantes. Ces huiles essentielles aident à équilibrer la production de sébum, revitalisent et tonifient la peau, laissant une sensation de fraîcheur et de vitalité.

Offrez à votre peau le luxe d'une routine beauté complète avec notre savon au macérat de carotte, une invitation à la fraîcheur et à la vitalité',
'Tout type de peau', 8.99, 'assets/images/products/placeholder2.png',
'huile d''olive(), huile de coco(), beurre de karité(), macérat de carotte(), huile essentiel d''orange(), huile essentiel de citron().'
,1,100,NOW(),1);

INSERT INTO PRODUCT (SKU, name, subname, introduction, description, application_type, unit_price, image_url, ingredients, active, units_in_stock, date_created, category_id)
VALUES ('SOAP-1002', 'Le Purifiant', 'Savon au charbon',
'Un savon au charbon actif permettant de purifier, nettoyer et réguler le sébum de votre peau.', 
'Explorez les bienfaits de notre savon détoxifiant au charbon actif, conçu pour une purification en profondeur de la peau. Le charbon actif pour détoxifier, désincruster les pores et nettoyer efficacement, offrant ainsi une expérience de soin complète. Ce savon, enrichi en beurre de karité, assure une hydratation en profondeur sans dessécher la peau.

L'ajout subtil d'huile essentielle d'eucalyptus apporte une dimension assainissante à la formule, régulant la production de sébum pour une peau équilibrée. Cette huile essentielle laisse également une sensation de fraîcheur revitalisante sur la peau. Pour une touche boisée relaxante, nous avons incorporé de l'huile essentielle de cèdre de l'Atlas, créant une expérience sensorielle apaisante.

Adapté à tous les types de peau, ce savon est particulièrement bienveillant envers les peaux mixtes à tendance grasse. Offrez à votre peau une purification profonde et une sensation de fraîcheur avec notre savon détoxifiant, une fusion équilibrée d'ingrédients naturels pour une peau éclatante et apaisée.',
'Peau normal à grasse', 8.99, 'assets/images/products/placeholder3.png',
'huile d''olive(), huile de coco(), beurre de karité(), huile de ricin(), charbon actif(), huile essentiel eucalyptus(), huile essentiel de cèdre de l''Atlas()',
1,100,NOW(),1);

INSERT INTO PRODUCT (SKU, name, subname, introduction, description, application_type, unit_price, image_url, ingredients, active, units_in_stock, date_created, category_id)
VALUES ('SOAP-1003', 'Le Anti-acnée', 'Savon au chanvre et romarin',
'Un savon régulateur de sébum, au propriété anti-inflammatoire et antispetique spécialement concu pour lutter contre l''acnée.', 
'Découvrez notre savon enrichi en huile de chanvre, une véritable source de bienfaits pour tous les peaux acnéeique. Cette huile, reconnue pour ses propriétés exceptionnelles, offre une hydratation profonde aux peaux sèches tout en équilibrant la production de sébum, ce qui en fait un allié précieux pour les peaux à tendance grasse.
L'huile de chanvre ne se contente pas seulement de réguler le sébum, elle apaise également les rougeurs, les irritations cutanées, et possède des propriétés antibactériennes. De plus, elle favorise le renouvellement cellulaire, contribuant ainsi à améliorer la cicatrisation des petites plaies laissées par les boutons d'acné.
Pour compléter cette formule exceptionnelle, nous avons ajouté trois huiles essentielles réputées dans le traitement de l'acné. L'huile essentielle d'arbre à thé, de Palmarosa et de romarin apportent leurs propriétés antibactériennes, anti-inflammatoires et antiseptiques, offrant des effets assainissants pour lutter contre l'apparition des boutons.
Offrez à votre peau le soin qu'elle mérite avec notre savon à l'huile de chanvre, une combinaison équilibrée d'ingrédients naturels pour une peau hydratée, équilibrée et résistante aux imperfections.',
'Peau grasse, à imperfection', 8.99, 'assets/images/products/placeholder1.png',
'huile d''olive(), huile de coco(), huile de ricin(), huile de chanvre(), huile essentiel d''arbre à thé(), huile essentiel de romarin(), huile essentiel de palamarosa(), argile verte().'
,1,100,NOW(),1);

INSERT INTO PRODUCT (SKU, name, subname, introduction, description, application_type, unit_price, image_url, ingredients, active, units_in_stock, date_created, category_id)
VALUES ('SOAP-1004', 'Le Madame', 'Savon à l''argan et rose de Damas',
'Un savon hydratant et à la bonne odeur de rose pour lutter contre les signes de l''âge et hydrater en profondeur les peaux matures.', 
'Explorez les bienfaits de notre savon à l'huile d'argan, une solution complète pour lutter contre les signes du temps. L'huile d'argan, riche en puissants antioxydants et vitamines, agit efficacement pour réduire l'apparition des rides et ridules, nourrissant la peau en profondeur et renforçant son élasticité. Cette huile est prisée pour ses propriétés hydratantes et anti-âge, en faisant ainsi un choix idéal tant pour les peaux matures que pour les peaux sèches.
Pour sublimer cette formule, nous avons ajouté de l'huile essentielle de rose de Damas. Reconnue pour son action anti-âge et vivifiante, elle contribue à améliorer l'élasticité et la qualité de la peau, tout en régénérant et tonifiant les peaux fatiguées. Son parfum délicat et envoûtant apporte une expérience sensorielle unique à chaque utilisation.
Bien que adapté à tous les types de peau, ce savon est tout particulièrement indiqué pour les peaux matures. Offrez à votre peau le luxe d'un soin régénérant avec notre savon à l'huile d'argan, une alliance naturelle pour une peau éclatante et revitalisée.',
'Peau mature', 8.99, 'assets/images/products/placeholder2.png',
'huile d''olive(), huile de coco(), huile de ricin(), huile d''argan(), huile essentiel de rose de Damas().',
,1,100,NOW(),1);

INSERT INTO PRODUCT (SKU, name, subname, introduction, description, application_type, unit_price, image_url, ingredients, active, units_in_stock, date_created, category_id)
VALUES ('SOAP-1005', 'Le Tout-doux', 'Savon au lait de chèvre et géranium',
'Notre savon le plus doux pour les peaux délicate en recherche d''hydratation.', 
'Découvrez notre Savon de Chèvre au Lait de Chèvre, spécialement formulé pour hydrater en douceur les peaux sensibles. Le lait de chèvre, riche en hydratants naturels et en vitamines, offre une expérience nourrissante unique. Grâce à son acide lactique, il confère une action exfoliante, permettant un nettoyage en profondeur et laissant la peau douce et veloutée.
Pour compléter cette formule bienfaisante, nous avons ajouté de l'huile essentielle de géranium. Reconnue pour ses propriétés toniques, elle est utilisée pour éliminer les impuretés tout en resserrant les pores de la peau, apportant ainsi de l'éclat au teint. Cette combinaison harmonieuse offre une solution douce et revitalisante pour une peau apaisée et radieuse.
Offrez à votre peau la tendresse du lait de chèvre et les bienfaits tonifiants de l'huile essentielle de géranium avec notre Savon de Chèvre, une invitation à la douceur et à l'éclat naturel de la peau.',
'Peau normal à sensible', 8.99, 'assets/images/products/placeholder3.png',
'huile d''olive(), huile de coco(), huile de ricin(), lait de chèvre(), huile essentiel de géranium().',
,1,100,NOW(),1);

INSERT INTO PRODUCT (SKU, name, subname, introduction, description, application_type, unit_price, image_url, ingredients, active, units_in_stock, date_created, category_id)
VALUES ('EXF-2000', 'Amande-café', 'Exfoliant à l''amande douce et café',
'Un exfoliant doux, moussant, nourrissant en profondeur, et ne laissant aucune rougeur. Parfait pour exfolier les peaux les plus sensible', 
'
Découvrez notre exfoliant à l'huile d'amande, une formule douce et nourrissante conçue spécialement pour les peaux sensibles. Enrichi en beurre de karité, beurre de cacao et miel, cet exfoliant offre une expérience de soin luxueuse.
L'agent exfoliant naturel utilisé est la marc de café, qui procure une exfoliation douce, idéale pour éliminer les impuretés tout en respectant la délicatesse des peaux sensibles. L'huile d'amande, riche en nutriments, contribue à nourrir la peau en profondeur, tandis que le beurre de karité et le beurre de cacao ajoutent une touche de douceur et d'hydratation.
Notre formule est spécifiquement exempte d'huiles essentielles pour s'assurer d'une expérience délicate, sans irritation pour les peaux sensibles. Offrez à votre peau un soin exfoliant tout en douceur avec notre exfoliant à l'huile d'amande, un geste tendre pour une peau éclatante et apaisée.',
'Peau sensible', 8.99, 'assets/images/products/placeholder1.png',
'huile d''olive(), huile de coco(), beurre de karité(), beurre de cacao(), huile d''amande douce(), miel, marc de café().',
,1,100,NOW(),2);

INSERT INTO PRODUCT (SKU, name, subname, introduction, description, application_type, unit_price, image_url, ingredients, active, units_in_stock, date_created, category_id)
VALUES ('EXF-2001', 'Soleil', 'Exfoliant Carotte, agrumes et abricot',
'Un exfoliant puissant ', 
'Explorez notre exfoliant éclat à base de macérat de carotte, d'huiles essentielles d'orange et de citron, et de poudre de noyaux d'abricot. Cette combinaison unique offre un soin exfoliant revigorant pour une peau radieuse.
Le macérat de carotte, riche en nutriments et en bêta-carotène, apporte ses bienfaits éclaircissants à la formule. Les huiles essentielles d'orange et de citron ajoutent une touche d'énergie et de fraîcheur tout en offrant des propriétés purifiantes. La poudre de noyaux d'abricot, en tant qu'agent exfoliant naturel, permet d'éliminer en douceur les cellules mortes de la peau, la laissant lisse et revitalisée.
Cette formule exfoliante est conçue pour apporter un éclat naturel à votre peau. Offrez-vous une expérience sensorielle vivifiante avec notre exfoliant à base de macérat de carotte, d'huiles essentielles d'orange et de citron, et de poudre de noyaux d'abricot, pour une peau éclatante de vitalité.',
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


