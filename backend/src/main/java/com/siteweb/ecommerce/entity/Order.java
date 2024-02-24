package com.siteweb.ecommerce.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.Set;
import java.util.HashSet;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OneToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;


//Entité pour récupérer les commandes dans a database


@Entity
@Table(name="orders")
@Getter
@Setter
	
public class Order {

	    @Id
	    @GeneratedValue(strategy = GenerationType.IDENTITY)
	    @Column(name="id")
	    private Long id;

	    @Column(name="order_tracking_number")
	    private String orderTrackingNumber;

	    @Column(name="total_quantity")
	    private int totalQuantity;

	    @Column(name="total_price")
	    private BigDecimal totalPrice;

	    @Column(name="status")
	    private String status;
	    
	    // Pour traquer les commandes
	    @Column(name="date_created")
	    @CreationTimestamp
	    private Date dateCreated;

	    @Column(name="last_updated")
	    @UpdateTimestamp
	    private Date lastUpdated;
	    
	    //Les relations avec les autres classes
	    
        // Une commande a plusieur produit commander (One to Many)
	    @OneToMany(cascade = CascadeType.ALL, mappedBy = "order")
	    private Set<OrderItem> orderItems = new HashSet<>();
	    
	    //Plusieurs commande peuvent etre associé à un client (Many to One)
	    @ManyToOne
	    @JoinColumn(name = "customer_id")
	    private Customer customer;
	    
	    //Une commande = Une adresse (OneToOne)  
	    @OneToOne(cascade = CascadeType.ALL)
	    @JoinColumn(name = "shipping_address_id", referencedColumnName = "id")
	    private Address shippingAddress;

	    @OneToOne(cascade = CascadeType.ALL)
	    @JoinColumn(name = "billing_address_id", referencedColumnName = "id")
	    private Address billingAddress;

	    
	    //Méthode pour remplir le tableau des produits commander
	    public void add(OrderItem item) {

	        if (item != null) {
	            if (orderItems == null) {
	                orderItems = new HashSet<>();
	            }

	            orderItems.add(item);
	            item.setOrder(this);
	        }
	    }
}
