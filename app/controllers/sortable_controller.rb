class SortableController < ApplicationController
  #
  # post /sortable/reorder, :klass => ["1", "3", "2"]
  #
  def reorder
    logger.debug "\ntest sort reorder 1.1.0"
    puts "\n\n----\ntest sort reorder 1.1.0", params.inspect, "----\n\n"
    klass, ids = parse_params
    attr = klass.sort_attribute
    puts "#{params[:event_id]}"
    if params[:event_id]
      models = klass.where(event_id: params[:event_id]).order(attr).to_a
    else
      models = klass.order(attr).to_a
    end
    puts "----\ntest sort reorder 1.1.0 on branch - LOADED #{models.count} models----\n\n"
    ids.each_with_index do |id, new_sort|
      model = models.find {|m| m.id == id }
      model.update_sort!(new_sort) if model.read_attribute(attr) != new_sort
    end
    head :ok
  end

private

  def parse_params
    klass_name = params.keys.first
    ids = params[klass_name].map {|id| id.to_i }
    [ klass_name.constantize, ids ]
  end
end
