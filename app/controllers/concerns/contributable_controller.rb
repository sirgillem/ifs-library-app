module ContributableController
  extend ActiveSupport::Concern

  def contributable_params
    [contributor_relations_attributes: [:id,
                                        :person_id,
                                        :role,
                                        :sequence,
                                        :_destroy,
                                        person_attributes: [:id,
                                                            :pre_titles,
                                                            :pre_names,
                                                            :key_name_prefix,
                                                            :key_name,
                                                            :post_names,
                                                            :key_name_suffix,
                                                            :qualifications,
                                                            :post_titles]]]
  end
end
