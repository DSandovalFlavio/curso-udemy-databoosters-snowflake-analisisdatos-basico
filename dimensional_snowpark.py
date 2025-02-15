import snowflake.snowpark as snowpark
from snowflake.snowpark.functions import sproc, udf, lit, col, concat_ws, split_part, sum, rank, extract, day, month, year, dayofweek, week

def create_views_snowpark(session: snowpark.Session):

    # Silver Layer
    daily_sales_df = session.table("SALES_DATA").select(
        col("ORDERDATE"),
        split_part(col("PURCHASEADDRESS"), ",", 2).alias("CITY"),
        col("PRODUCT"),
        col("CATEGORY"),
        col("QUANTITYORDERED"),
        col("PRICEEACH")
    ).groupBy(
        col("ORDERDATE"),
        col("CITY"),
        col("PRODUCT"),
        col("CATEGORY")
    ).agg(
        sum(col("QUANTITYORDERED")).alias("QUANTITYORDERED"),
        sum(col("QUANTITYORDERED") * col("PRICEEACH")).alias("SALES")
    ).orderBy(col("ORDERDATE"))

    daily_sales_df.create_or_replace_view("DAILY_SALES_VW")

    # Gold Layer

    dim_product_df = daily_sales_df.groupBy(col("PRODUCT"), col("CATEGORY")).agg(rank().over(partitionBy(), orderBy(col("PRODUCT"), col("CATEGORY"))).alias("PRODUCTID"),col("PRODUCT"), col("CATEGORY"))
    dim_product_df.create_or_replace_view("GOLD_DIM_PRODUCT_VW")

    dim_city_df = daily_sales_df.groupBy(col("CITY")).agg(rank().over(partitionBy(), orderBy(col("CITY"))).alias("CITYID"), col("CITY"))
    dim_city_df.create_or_replace_view("GOLD_DIM_CITY_VW")


    dim_calendar_df = session.table("DAILY_SALES_VW").select(col("ORDERDATE")).distinct().select(
        col("ORDERDATE"),
        extract(day(col("ORDERDATE"))).alias("DDAY"),
        extract(month(col("ORDERDATE"))).alias("DMONTH"),
        extract(year(col("ORDERDATE"))).alias("DYEAR"),
        extract(dayofweek(col("ORDERDATE"))).alias("DDAYOFWEEK"),
        extract(week(col("ORDERDATE"))).alias("DWEEK")
    )
    dim_calendar_df.create_or_replace_view("GOLD_DIM_CALENDAR_VW")

    fact_sales_df = daily_sales_df.alias("S").join(
        dim_product_df.alias("DP"),
        (col("S.PRODUCT") == col("DP.PRODUCT")) & (col("S.CATEGORY") == col("DP.CATEGORY"))
    ).join(
        dim_city_df.alias("DC"),
        col("S.CITY") == col("DC.CITY")
    ).select(
        col("S.ORDERDATE"),
        col("DP.PRODUCTID"),
        col("DC.CITYID"),
        col("S.QUANTITYORDERED"),
        col("S.SALES")
    )

    fact_sales_df.create_or_replace_view("GOLD_FACT_SALES_VW")

    print("Vistas creadas exitosamente.")


# Ejemplo de uso (asumiendo que 'session' es tu sesión de Snowpark):
# create_views_snowpark(session)