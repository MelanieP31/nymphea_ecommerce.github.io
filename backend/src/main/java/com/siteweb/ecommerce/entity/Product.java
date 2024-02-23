package com.siteweb.ecommerce.entity;

import java.math.BigDecimal;
import java.sql.Date;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Table;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import lombok.Data;

//Annotation Table pour se référer au nom dans la bdd
//Annotation Data permet de générer automatiquement les getters/setters
@Entity
@Table(name="product")
@Data
public class Product {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="id")
	private Long Id;
	
	//Lié à category (contient la foreign clé de category) precisé le nom de la colonne jointe category_id
	@ManyToOne
	@JoinColumn(name = "category_id", nullable = false) //ne peut pas etre null
	private ProductCategory category;
	
	@Column(name="sku")
	private String sku;
	
	@Column(name="name")
	private String name;
	
	@Column(name="subname")
	private String subname;
	
	@Column(name="introduction")
	private String introduction;
	
	@Column(name="description")
	private String description;

	@Column(name="unit_price")
	private BigDecimal unitPrice;
	
	@Column(name="image_url")
	private String imageUrl;
	
	@Column(name="ingredients")
	private String ingredients;
	
	@Column(name="active")
	private boolean active;
	
	@Column(name="units_in_stock")
	private int unitsInStock;
	
	@Column(name="date_created")
	//Speciale annotation pour que springboot manage automatiquelent les date de creation et d'update.
	@CreationTimestamp
	private Date dateCreated;
	
	@Column(name="last_updated")
	@UpdateTimestamp
	private Date lastUpdate;
}
