package com.siteweb.ecommerce.dao;
import com.siteweb.ecommerce.entity.Product;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

//Créer notre Rest API avec endpoint product issu de l'entité produit qu'on a créer
//extends JpaRepository (preciser l'entité et type de la clé primaire)
@RepositoryRestResource
public interface ProductRepository extends JpaRepository<Product, Long> {

	//Trier les produits par category, querymethod : findby,readby... Srping : SELECT(find by) * FROM product (Page<Product>) where category_id =? (Long Id); Spring DataReference Manual
	//Page : support pour la pagination sublist of a list of object. Info totalElement et autre (utilie qd bcp d'obet) Peageable Pagenumber, pageSize ... (default 20 element)
	//Créer un endpoint .../products/search/findByCategoryId
    Page<Product> findByCategoryId(@Param("id") Long id, Pageable pageable);
    //Containing = LIKE (SELECT Product p WHERE p.name LIKE (?)
    Page<Product> findByNameContaining(@Param("name") String name, Pageable pageable);
}

