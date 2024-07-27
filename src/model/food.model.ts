import { IRestaurant, Restaurant } from "./restaurant.model";
import { BelongsTo, Column, Table, Model } from "sequelize-typescript";


export interface IFood{
    id : number
    food_name : string
    price : number
    food_image_url : string
    restaurant_id : number

    restaurant : IRestaurant
}

@Table({tableName : 'foods', timestamps : false})
export class Food extends Model<IFood> implements IFood{
    @Column({
        primaryKey : true,
        autoIncrement : true
    })
    id: number;

    @Column
    food_name: string;

    @Column
    price: number;

    @Column
    food_image_url: string;

    @Column
    restaurant_id: number;

    @BelongsTo(() => Restaurant, {
        foreignKey : 'restaurant_id',
        targetKey : "id"
    })
    restaurant: Restaurant;

}