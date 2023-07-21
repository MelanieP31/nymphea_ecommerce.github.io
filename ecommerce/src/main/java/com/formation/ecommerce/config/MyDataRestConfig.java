package com.formation.ecommerce.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;
import org.springframework.data.rest.webmvc.config.RepositoryRestConfigurer;
import org.springframework.http.HttpMethod;
import org.springframework.web.servlet.config.annotation.CorsRegistry;

import com.formation.ecommerce.entity.Product;
import com.formation.ecommerce.entity.ProductCategory;

@Configuration
public class MyDataRestConfig implements RepositoryRestConfigurer {

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
			
		
		//RepositoryRestConfigurer.super.configureRepositoryRestConfiguration(config, cors);
	}
	

}
