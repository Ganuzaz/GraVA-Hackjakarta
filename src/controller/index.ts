import sequelize from "../model";
import { Food } from "../model/food.model";
import express, { Request, Response } from "express";
import { QueryTypes, Sequelize } from "sequelize";

export default {
	getRestaurants: async (req: Request, res) => {
		const { longitude, latitude } = req.body;

		try {
			const result = await sequelize.query(
				`
            WITH ranked_foods AS (
                SELECT 
                    foods.id,
                    foods.restaurant_id,
                    :backendUrl || '/' || foods.food_image_url as food_image_url,
                    ROW_NUMBER() OVER (PARTITION BY foods.restaurant_id ORDER BY foods.id) AS rn
                FROM foods
            )
            SELECT restaurants.*, ranked_foods.food_image_url FROM restaurants
            left join ranked_foods on ranked_foods.restaurant_id = restaurants.id and ranked_foods.rn = 1
            WHERE ST_DWithin(
                restaurants.geom::geography,
                ST_SetSRID(ST_MakePoint(:longitude, :latitude), 4326)::geography,
                10000
            )
        `,
				{
					replacements: {
						longitude,
						latitude,
						backendUrl: process.env.BACKEND_URL,
					},
					type: QueryTypes.SELECT,
				}
			);

			return res.status(200).json(result);
		} catch (error) {
            console.error(error)
			return res.status(400).json(error);
		}
	},
	getFoodList: async (req, res) => {
		const { restaurant_id } = req.params;

		try {
			const result = await Food.findAll({
				where: {
					restaurant_id: restaurant_id,
				},
			});

			return res.status(200).json(result);
		} catch (error) {
            console.error(error)
			return res.status(400).json(error);
		}
	},
};
