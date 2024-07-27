import { Table, Model, Column, HasMany, DataType } from "sequelize-typescript";
import { Food, IFood } from "./food.model";


export interface IRestaurant{
    id : number
    restaurant_name : string
    restaurant_food_type : number
    latitude : number
    longitude : number
    geom: { type: string, coordinates: [number, number] }
    foods : IFood[]
}

@Table({modelName : "restaurants", timestamps : false})
export class Restaurant extends Model<IRestaurant> implements IRestaurant{
    @Column({
        primaryKey : true,
        autoIncrement : true
    })
    id: number;
    @Column
    restaurant_name: string;
    @Column
    restaurant_food_type: number;
    @Column
    latitude: number;
    @Column
    longitude: number;

    @HasMany(()=>Food, {
        foreignKey : "restaurant_id",
    })
    foods : Food[]

    @Column({
        type: DataType.GEOMETRY('POINT', 4326),
        allowNull: false,
      })
      geom!: { type: string, coordinates: [number, number] };
}