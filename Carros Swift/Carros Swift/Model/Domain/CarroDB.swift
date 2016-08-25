//
//  CarroDB.swift
//  Carros Swift
//
//  Created by Antonio Lopes on 8/16/16.
//  Copyright © 2016 Antonio Lopes. All rights reserved.
//

import Foundation

class CarroDB {
    var db: SQLiteHelper
    
    init() {
        self.db = SQLiteHelper(database: "carros.db")
        self.createTables()
    }
    
    func createTables() {
        let sql = "create table if not exists carro (id integer primary key autoincrement, nome text, desc text, url_foto text, url_info text, url_video text, latitude text, longitude text, tipo text);"
        self.db.execSql(sql)
    }
    
    func getCarrosByType(tipo: String) -> Array<Carro> {
        var carros : Array<Carro> = []
        let stmt = self.db.query("select * from carro where tipo = ?", params: [tipo])
        while self.db.nextRow(stmt) {
            let c = Carro()
            c.id        = self.db.getInt(stmt, index: 0)
            c.nome      = self.db.getString(stmt, index: 1)
            c.desc      = self.db.getString(stmt, index: 2)
            c.url_foto  = self.db.getString(stmt, index: 3)
            c.url_info  = self.db.getString(stmt, index: 4)
            c.url_video = self.db.getString(stmt, index: 5)
            c.longitude = self.db.getString(stmt, index: 6)
            c.latitude  = self.db.getString(stmt, index: 7)
            c.tipo      = self.db.getString(stmt, index: 8)
            
            carros.append(c)
        }
        self.db.closeStatement(stmt)
        return carros
    }
    
    func save(carro: Carro) {
        if carro.id == 0 {
            //Insert
            let sql = "insert or replace into carro (nome, desc, url_foto, url_info, url_video, latitude, longitude, tipo) values (?, ?, ?, ?, ?, ?, ?, ?)"
            let params = [carro.nome, carro.desc, carro.url_foto, carro.url_info, carro.url_video, carro.latitude, carro.longitude, carro.tipo]
            let id = self.db.execSql(sql, params: params as Array<AnyObject>)
            print("Carro \(carro.nome), id: \(id) salvo com sucesso!")
        } else {
            let sql = "update carro se nome = ?, desc = ?, url_foto = ?, url_info = ?, url_video = ?, latitude = ?, longitude = ?, tipo = ? where id = ? values (?, ?, ?, ?, ?, ?, ?, ?, ?)"
            let params = [carro.nome, carro.desc, carro.url_foto, carro.url_info, carro.url_video, carro.latitude, carro.longitude, carro.tipo, carro.id]
            let id = self.db.execSql(sql, params: params as Array<AnyObject>)
            print("Carro \(carro.nome), id: \(id) atualizado com sucesso!")
        }
    }
    
    func delete(carro: Carro) {
        let sql = "delete from carro where id = ?"
        self.db.execSql(sql, params: [carro.id])
        print("Carro \(carro.nome), id: \(carro.id) excluído com sucesso!")
    }
    
    func deleteCarrosByTipo(tipo: String) {
        let carros = self.getCarrosByType(tipo)
        for carro in carros {
            self.delete(carro)
        }
    }
    
    func close() {
        self.db.close()
    }
}