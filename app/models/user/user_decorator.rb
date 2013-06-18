module CartoDB
  module UserDecorator
    def data(options = {})
      data = { 
        id: self.id,
        email: self.email,
        username: self.username,
        account_type: self.account_type,
        table_quota: self.table_quota,
        table_count: self.table_count,
        byte_quota: self.quota_in_bytes,
        remaining_table_quota: self.remaining_table_quota,
        remaining_byte_quota: self.remaining_quota.to_f,
        api_calls: self.get_api_calls["per_day"],
        api_key: self.get_map_key,
        layers: self.layers.map(&:public_values),
        actions: {
          private_tables: self.private_tables_enabled,
          dedicated_support: self.dedicated_support?,
          import_quota: self.import_quota,
          remove_logo: self.remove_logo?
        }
      }

      if !options[:extended]
        data
      else
        data.merge({
          :real_table_count           => self.real_tables.size,
          :last_active_time           => self.get_last_active_time,
          :db_size_in_bytes           => self.db_size_in_bytes
        })
      end
    end
  end
end
