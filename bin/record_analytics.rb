require_relative '../lib/google/analytics'

analytics = Google::Analytics.new

id = 'ga:xxxxxxxxx'
metrics = 'ga:sessions,ga:users,ga:pageviews'
filters = 'ga:medium==organic'

normal  = analytics.get_ga_data(id, metrics)
organic = analytics.get_ga_data(id, metrics, filters)

normal['ga:organic_sessions'] = organic['ga:sessions']

p normal
