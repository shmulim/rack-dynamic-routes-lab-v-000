class Application

  @@items = [Item.new("Apples",5.23), Item.new("Oranges",2.43)]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      resource = req.path.split('/items/').last
      item = @@items.find { |i| i.name == resource }
        if item
          resp.write item.price
          resp.status = 200
        else
          resp.write "Item not found"
          resp.status = 400
        end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end

end