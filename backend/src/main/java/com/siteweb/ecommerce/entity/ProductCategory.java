package com.siteweb.ecommerce.entity;

import java.util.Set;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Table;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import lombok.Data;

@Entity
@Table(name="product_category")
@Data
public class ProductCategory {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private Long Id;
	
	@Column(name="category_name")
	private String categoryName;
	
	//Relation avec le set product (1 categorie pls produits) set de product mappé dans category (le nom qu'on va donner dans l'entité prduit).
	//Cascade : perform une action sur une entité, cela se répercute sur l'entité associé
	@OneToMany(cascade=CascadeType.ALL, mappedBy="category")
	private Set<Product> products;
	
	

}
