namespace sap.capire.bookshop;
using { Currency, managed, cuid } from '@sap/cds/common';
using { sap.capire.products.Products } from '../../products';


entity Books : Products {
    /*key ID : Integer;
    title : localized String(111);
    descr : localized String(1111);*/ //Se agrego ahora desde products
    author : Association to Authors;
    /*stock : Integer;
    price : Decimal(9,2);
    currency : Currency;*/ //Se agrego ahora desde products
}

entity Magazines : Products {
    publisher : String
}

@cds.autoexpose
entity Authors : managed {
    key ID : Integer;
    name : String(111);
    dateOfBirth  : Date;
    dateOfDeath  : Date;
    placeOfBirth : String;
    placeOfDeath : String;
    books : Association to many Books on books.author = $self;
}

entity Orders : managed, cuid {
    //key ID : UUID;
    OrderNo: String @title:'Order Number'; //readable key
    Items : Composition of many OrderItems on Items.parent = $self;
    total : Decimal(9,2) @readonly;
    currency : Currency;
}

entity OrderItems : cuid {
    //key ID : UUID;
    parent : Association to Orders;
    book : Association to Books;
    amount :  Integer;
    netAmount : Decimal(9,2);    
}

entity Movies : addditioanlInfo {
    key ID : Integer;
    name : String(111);
}

aspect addditioanlInfo{
    genre: String(100);
    language: String(200);    
}