package com.siteweb.ecommerce.config;

import java.util.List;
import java.util.Set;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;
import org.springframework.data.rest.webmvc.config.RepositoryRestConfigurer;
import org.springframework.http.HttpMethod;
import org.springframework.web.servlet.config.annotation.CorsRegistry;

import com.siteweb.ecommerce.entity.Product;
import com.siteweb.ecommerce.entity.ProductCategory;
import com.siteweb.ecommerce.entity.Order;

import jakarta.persistence.EntityManager;
import jakarta.persistence.metamodel.EntityType;

//3 truc ici :
//1-Mettre le cross origin de facon non hardcode 
//2-Enlever les HttpMethod pour la securité et le mettre en readOnly --> disableMethods
//3-Exposer les Id dans l'API pour y avoir accès facilement et pouvoir classer les produits/categorie, selection un produit pour ces detail --> méthode exposeId


@Configuration
public class MyDataRestConfig implements RepositoryRestConfigurer {
	
	//pour ne pas "hardcoder" l'origine, rentrer dans seulement aaplication.properties
	@Value("${allowed.origins}")
	private String[] theAllowedOrigins;

    private EntityManager entityManager;

    public MyDataRestConfig(EntityManager theEntityManager) {
        entityManager = theEntityManager;
    }
//La méthode qui appelle les petites méthodes (et defini les application):
//Problem springDataRest donne acces a toute les méthode http, on veut en Read only. Donc tant qu'on sait pas faire SpringSecurity : DisabledMéthode ! 
    public void configureRepositoryRestConfiguration(RepositoryRestConfiguration config, CorsRegistry cors) {

    	//liste des methode a enlever ("defini les applications")
        HttpMethod[] theUnsupportedActions = {HttpMethod.PUT, HttpMethod.POST, HttpMethod.DELETE, HttpMethod.PATCH};

        // disable HTTP methods for ProductCategory: PUT, POST and DELETE (methode dessous)-->Appele la methode créer dessous avec ces param
        disableHttpMethods(Product.class, config, theUnsupportedActions);
        disableHttpMethods(ProductCategory.class, config, theUnsupportedActions);


        // appelle notre méthode expose Id
        exposeIds(config);
        
        //Cors mapping pour notre allowedOrigines
        cors.addMapping(config.getBasePath() + "/**").allowedOrigins(theAllowedOrigins);
    }

    //Créer une méthode prenant en param le nom de la class, config?, methode a enlever)
    private void disableHttpMethods(Class<?> theClass, RepositoryRestConfiguration config, HttpMethod[] theUnsupportedActions) {
        config.getExposureConfiguration()
                .forDomainType(theClass)
                .withItemExposure((metdata, httpMethods) -> httpMethods.disable(theUnsupportedActions))
                .withCollectionExposure((metdata, httpMethods) -> httpMethods.disable(theUnsupportedActions));
    }
//Créer la méthode exposeId dans l'API.
    private void exposeIds(RepositoryRestConfiguration config) {

        // expose entity ids
        //

        // - Dans un Set (appler entities) on recup des entity (method de entityManager)(id des classes annoté @Entity)
        Set<EntityType<?>> entities = entityManager.getMetamodel().getEntities();

        // - Créer un tableau (ArrayList) 
        @SuppressWarnings("rawtypes")
		List<Class> entityClasses = new ArrayList<>();

        // - pour chaque itération des entities, on rentre dans le tableau leur type
        for (@SuppressWarnings("rawtypes") EntityType tempEntityType : entities) {
            entityClasses.add(tempEntityType.getJavaType());
        }

        // - converti en array [], et j'appele la méthode du RepositoryRestConfig (renommer config) exposeIdsFor()
        @SuppressWarnings("rawtypes")
		Class[] domainTypes = entityClasses.toArray(new Class[0]);
        config.exposeIdsFor(domainTypes);
    }
}