```ruby
sql = \
  <<-sql
    UPDATE qrscan_records SET wechat_qrcode_id =
    (SELECT id FROM wechat_qrcodes WHERE scene = qrscan_records.scene)
  sql

ActiveRecord::Base.connection.execute(sql)
```
