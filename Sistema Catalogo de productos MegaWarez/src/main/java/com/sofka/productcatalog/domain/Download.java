package com.sofka.productcatalog.domain;

import com.fasterxml.jackson.annotation.JsonBackReference;
import lombok.Data;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import java.io.Serializable;
import java.time.Instant;

@Data
@Entity
@Table(name = "download")
public class Download implements Serializable {
    /**
     * Variable usada para manejar el tema del identificador de la tupla (consecutivo)
     */
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "dwn_id", nullable = false)
    private Integer id;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = User.class, optional = false)
    @JoinColumn(name = "dwn_user_id", nullable = false)
    @JsonBackReference
    private User user;

    @ManyToOne(fetch = FetchType.LAZY, targetEntity = Item.class, optional = false)
    @JoinColumn(name = "dwn_item_id", nullable = false)
    @JsonBackReference
    private Item item;

    @Column(name = "dwn_created_at", nullable = false)
    private Instant dwnCreatedAt;


}