CREATE EXTENSION IF NOT EXISTS postgis;

CREATE TABLE restaurants (
    id SERIAL PRIMARY KEY,
    restaurant_name VARCHAR(255) NOT NULL,
    restaurant_food_type VARCHAR(255) NOT NULL,
    latitude DOUBLE PRECISION NOT NULL,
    longitude DOUBLE PRECISION NOT NULL,
    geom GEOMETRY(Point, 4326)
);


-- Create the foods table
CREATE TABLE foods (
    id SERIAL PRIMARY KEY,
    food_name VARCHAR(255) NOT NULL,
    price NUMERIC(10, 2) NOT NULL,
    food_image_url TEXT NOT NULL,
    restaurant_id INT NOT NULL,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants (id)
);

-- Function to generate random points within 10 km
CREATE OR REPLACE FUNCTION random_point_within_10km(lat DOUBLE PRECISION, lon DOUBLE PRECISION)
RETURNS TABLE (latitude DOUBLE PRECISION, longitude DOUBLE PRECISION) AS $$
DECLARE
    r DOUBLE PRECISION;
    u DOUBLE PRECISION;
    v DOUBLE PRECISION;
    w DOUBLE PRECISION;
    t DOUBLE PRECISION;
    x DOUBLE PRECISION;
    y DOUBLE PRECISION;
    lat_offset DOUBLE PRECISION;
    lon_offset DOUBLE PRECISION;
BEGIN
    r := 10.0 / 111.32; -- Approx radius in degrees (10 km)
    u := random();
    v := random();
    w := r * sqrt(u);
    t := 2 * pi() * v;
    x := w * cos(t);
    y := w * sin(t);
    lat_offset := x / cos(radians(lon));
    lon_offset := y;

    RETURN QUERY SELECT lat + lat_offset, lon + lon_offset;
END;
$$ LANGUAGE plpgsql;


-- Insert sample data into restaurants and foods tables with real names, foods types, foods names, and estimated prices
DO $$
DECLARE
    restaurant_id INT;
    restaurant_names TEXT[] := ARRAY[
        'Warung Sederhana', 'Rumah Makan Padang', 'Sate Khas Senayan', 
        'Bebek Tepi Sawah', 'Bakmi GM', 'Gado-Gado Boplo', 
        'Soto Betawi H. Maruf', 'Ayam Goreng Suharti', 'Martabak Orins', 
        'Nasi Uduk Kebon Kacang'
    ];
    food_types TEXT[] := ARRAY[
        'Padang', 'Javanese', 'Sundanese', 'Balinese', 
        'Chinese-Indonesian', 'Betawi', 'Manado', 'Makassar', 'Medan', 'Palembang'
    ];
    food_names TEXT[][] := ARRAY[
        ARRAY['Rendang', 'Sate Padang', 'Ayam Pop', 'Dendeng Balado', 'Gulai'],
        ARRAY['Gudeg', 'Rawon', 'Pecel', 'Lontong Balap', 'Tahu Tek'],
        ARRAY['Nasi Timbel', 'Sate Maranggi', 'Karedok', 'Nasi Liwet', 'Empal Gentong'],
        ARRAY['Ayam Betutu', 'Babi Guling', 'Lawar', 'Sate Lilit', 'Nasi Jinggo'],
        ARRAY['Bakmi Goreng', 'Nasi Goreng', 'Cap Cay', 'Kwetiau', 'Ayam Koloke'],
        ARRAY['Gado-Gado', 'Kerak Telor', 'Soto Betawi', 'Nasi Uduk', 'Asinan Betawi'],
        ARRAY['Tinutuan', 'Cakalang Fufu', 'Ayam Woku', 'Paniki', 'Brenebon'],
        ARRAY['Coto Makassar', 'Pallu Basa', 'Konro', 'Sop Saudara', 'Mie Titi'],
        ARRAY['Bika Ambon', 'Soto Medan', 'Nasi Goreng Medan', 'Lontong Medan', 'Martabak Medan'],
        ARRAY['Pempek', 'Tekwan', 'Model', 'Laksan', 'Martabak HAR']
    ];
    food_prices NUMERIC[][] := ARRAY[
        ARRAY[50000, 40000, 35000, 45000, 40000],
        ARRAY[30000, 35000, 20000, 25000, 20000],
        ARRAY[30000, 40000, 25000, 35000, 30000],
        ARRAY[40000, 50000, 30000, 45000, 20000],
        ARRAY[35000, 30000, 40000, 35000, 30000],
        ARRAY[25000, 20000, 30000, 20000, 15000],
        ARRAY[30000, 45000, 35000, 50000, 25000],
        ARRAY[40000, 35000, 45000, 30000, 35000],
        ARRAY[20000, 30000, 35000, 25000, 30000],
        ARRAY[25000, 30000, 25000, 20000, 30000]
    ];
BEGIN
    FOR i IN 1..10 LOOP
        INSERT INTO restaurants (restaurant_name, restaurant_food_type, latitude, longitude, geom)
        SELECT 
            restaurant_names[i], 
            food_types[i], 
            lat, 
            lon, 
            ST_SetSRID(ST_MakePoint(lon, lat), 4326)
        FROM random_point_within_10km(-6.2943376, 106.7833228) AS point(lat, lon)
        RETURNING id INTO restaurant_id;

        -- Insert related foods items for each restaurant
        FOR j IN 1..5 LOOP
            INSERT INTO foods (food_name, price, food_image_url, restaurant_id)
            VALUES (
                food_names[i][j], 
                food_prices[i][j], 
                'food/'|| lower(regexp_replace(food_names[i][j], '\s', '_', 'g')) || '.jpg', 
                restaurant_id
            );
        END LOOP;
    END LOOP;
END;
$$;