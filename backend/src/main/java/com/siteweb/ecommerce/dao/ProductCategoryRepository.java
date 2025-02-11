package com.siteweb.ecommerce.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.rest.core.annotation.RepositoryRestResource;

import com.siteweb.ecommerce.entity.ProductCategory;

//Créer notre RestAPI avec l'entité ProductCategory 
//Custom endpoint (name JSON productCategory et le nom de l'endpoint /product-category)
@RepositoryRestResource(collectionResourceRel = "productCategory", path ="product-category")
public interface ProductCategoryRepository extends JpaRepository<ProductCategory, Long>{

}