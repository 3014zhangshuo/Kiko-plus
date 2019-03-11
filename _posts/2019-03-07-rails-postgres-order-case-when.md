```ruby
def self.order_by_ids(ids)
  order_by = ["CASE"]
  ids.each.with_index do |id, index|
    order_by << "WHEN id=#{id} THEN #{index}"
  end
  order_by << ["END"]
  order_by.join(" ")
end
```

```sql
SELECT * FROM table WHERE arr @> ARRAY['s']::varchar[]
```

```sql
SELECT value_variable = ANY ('{1,2,3}'::int[])
```

[Rails Sorting the record based on the array passed in where condition](https://stackoverflow.com/questions/31067428/rails-sorting-the-record-based-on-the-array-passed-in-where-condition)
[https://stackoverflow.com/questions/16606357/how-to-make-a-select-with-array-contains-value-clause-in-psql](https://stackoverflow.com/questions/16606357/how-to-make-a-select-with-array-contains-value-clause-in-psql)
[Check if value exists in Postgres array](https://stackoverflow.com/questions/11231544/check-if-value-exists-in-postgres-array)
[Ordering a query result set by an arbitrary list in PostgreSQL](https://gist.github.com/cpjolicoeur/3590737)
