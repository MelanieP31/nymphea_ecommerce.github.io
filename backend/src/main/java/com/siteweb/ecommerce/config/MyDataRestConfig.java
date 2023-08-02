package com.siteweb.ecommerce.config;

import java.util.List;
import java.util.Set;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;
import org.springframework.data.rest.webmvc.config.RepositoryRestConfigurer;
import org.springframework.http.HttpMethod;
import org.springframework.web.servlet.config.annotation.CorsRegistry;

import com.siteweb.ecommerce.entity.Product;
import com.siteweb.ecommerce.entity.ProductCategory;

import jakarta.persistence.EntityManager;
import jakarta.persistence.metamodel.EntityType;

@Configuration
public class MyDataRestConfig implements RepositoryRestConfigurer {

	private EntityManager entityManager; 
	
	@Autowired
	public MyDataRestConfig(EntityManager theEntityManager) {
		entityManager = theEntityManager;
	}
	

	
	
	@Override
	public void configureRepositoryRestConfiguration(RepositoryRestConfiguration config, CorsRegistry cors) {
		
		HttpMethod[] theUnsupportedActions = {HttpMethod.PUT, HttpMethod.POST, HttpMethod.DELETE};

		//Desactive HTTP methods for Product : PUT POST et DELETE
	
		config.getExposureConfiguration()
			.forDomainType(Product.class)
			.withItemExposure((metdata, httpMethods)-> httpMethods.disable(theUnsupportedActions))
			.withCollectionExposure((metdata, httpMethods)-> httpMethods.disable(theUnsupportedActions));
			
		//Desactive HTTP methods for ProductCategory : PUT POST et DELETE

		config.getExposureConfiguration()
			.forDomainType(ProductCategory.class)
			.withItemExposure((metdata, httpMethods)-> httpMethods.disable(theUnsupportedActions))
			.withCollectionExposure((metdata, httpMethods)-> httpMethods.disable(theUnsupportedActions));
			
		
		//call an internal helper method exposeId
		exposeIds(config);
	}




	private void exposeIds(RepositoryRestConfiguration config) {
		Set<EntityType<?>> entities = entityManager.getMetamodel().getEntities();
		
		List<Class> entityClasses = new ArrayList<>();
		
		for (EntityType tempEntityType : entities) {
			entityClasses.add(tempEntityType.getJavaType());
		}
		
		Class[] domainTypes = entityClasses.toArray(new Class[0]);
		config.exposeIdsFor(domainTypes);
		
	}
	

}
