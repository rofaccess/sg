Warden::Manager.after_authentication do |user, auth, opts|
  CustomLogging.create(item_type: 'Auth', item_id: user.id, event: 'login', whodunnit: user.id, object: nil, created_at: DateTime.now)
end

Warden::Manager.before_logout do |user, auth, opts|
  CustomLogging.create(item_type: 'Auth', item_id: user.id, event: 'logout', whodunnit: user.id, object: nil, created_at: DateTime.now)
end