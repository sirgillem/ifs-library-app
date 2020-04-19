module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = 'IFS Library'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  # This method creates a link with `data-id` `data-fields` attributes. These
  # attributes are used to create new instances of the nested fields through
  # Javascript.
  def link_to_nested_fields(name, f, association, new_object, button_class,
                            form_location = nil)
    # Saves the unique ID of the object into a variable.
    # This is needed to ensure the key of the associated array is unique. This
    # makes parsing the content in the `data-fields` attribute easier through
    # Javascript.
    id = new_object.object_id

    # `child_index` is used to ensure the key of the associated array is unique,
    # and that it matched the value in the `data-id` attribute.
    # `person[association_attributes][child_index_value][_destroy]`
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      # The form may be located in some other view folder (e.g. shared). build
      # this from the provided location - will be in
      # `views/location/_association_fields.html.erb`. Default location is the
      # controller for the overall form.
      partial_parts = [form_location, association.to_s.singularize + '_fields']
      form_partial = partial_parts.compact.join('/')
      # The render function also needs to be passed the value of 'builder',
      # because the partial needs this to render the form tags.
      render(form_partial, f: builder)
    end

    # This renders a simple link, but passes information into `data` attributes.
    # This info can be named anything we want, but in this case we chose
    # `data-id:` and `data-fields:`.
    # The `id:` is from `new_object.object_id`.
    # The `fields:` are rendered from the `fields` blocks.
    # We use `gsub("\n", "")` to remove anywhite space from the rendered partial
    # The `id:` value needs to match the value used in `child_index: id`.
    link_to(name, '#', class: button_class,
                       data: { id: id,
                               fields: fields.gsub('\n', '') })
  end

  # Create the link to add a new set of fields for the 'many' side of a
  # relation.
  def link_to_add_fields(name, f, association, form_location = nil)
    # Takes an object (@person) and creates a new instance of its associated
    # model (:addresses)
    # To better understand, run the following in your terminal:
    # rails c --sandbox
    # @person = Person.new
    # new_object = @person.send(:addresses).klass.new
    new_object = f.object.send(association).klass.new

    link_to_nested_fields(name, f, association, new_object, 'add_fields',
                          form_location)
  end

  # Create the link to add a new set of fields for the 'one' side of a
  # relation
  def link_to_new_fields(name, f, association, form_location = nil)
    create_association = ['create', association].join('_')
    new_object = f.object.send(create_association.to_sym)
    link_to_nested_fields(name, f, association, new_object, 'new_fields',
                          form_location)
  end
end
