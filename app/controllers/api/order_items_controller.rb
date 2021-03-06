class OrderItemsController < ApplicationController
 respond_to :html, :json

  def index
  #  @order_items = if params[:request]
      #fields = if params[:fields] == "all_columns"
      #  %w(login_name first_name last_name role)
      #else
      #  params[:fields] 
     # end
     # order_item.send params[:scope].intern, fields, params[:request]
  #  else
   #   order_item.scoped
   # end

   # @order_items = @order_items.reorder(params[:itemstableBy]).page(params[:currentPage]).per(params[:perPage])

   # @pagination = {
      #current_page: @order_items.current_page,
      #num_pages:    @order_items.num_pages,
     # per_page:     @order_items.limit_value,
     # total_count:  order_item.count,
   # }
    @order = Order.find params[:order_id]

    @all_items = @order.items.select("item_id,item_name,item_description,dimension,price,quantity,price_per_line")
    
    respond_to do |format|
      format.html
      format.json do
        respond_with({ models: @order_items })#}.merge @pagination)
      end
    end
  end

  def show
    @order_item = OrderItem.find(params[:id])       
    @order = Order.find(@order_item.order_id)
    
    @all_items = @order.items.select("item_id,item_name,item_description,dimension,price,quantity,price_per_line")
    
    respond_to do |format|
      format.html # show.html.erb      
      format.json { render json: @all_items }
      #format.json { render json: { order_item: @order_item, itemstable_items: @all_items.to_json().html_safe } }
    end
  end

  def create
    @order_item = OrderItem.create params[:order_item]
    respond_to do |format|
      format.html { redirect_to user_path(@order_item) }
      format.json { respond_with @order_item }
    end
  end

  def update
    @order_item = OrderItem.find params[:id]
    @order_item.update_attributes params[:order_item]
    respond_to do |format|
      format.html
      format.json { respond_with @order_item }
    end
  end

  def destroy
    respond_with OrderItem.destroy(params[:id])
  end
end