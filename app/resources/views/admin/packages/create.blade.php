 <div class="modal fade" id="createModal" tabindex="-1" role="dialog" arititletotala-labelledby="exampleModalCenterTitle"
     aria-hidden="true">
     <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
         <div class="modal-content">
             <div class="modal-header">
                 <h5 class="modal-title" id="exampleModalLongTitle">{{ __('Add Package') }}</h5>
                 <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                     <span aria-hidden="true">&times;</span>
                 </button>
             </div>
             <div class="modal-body">

                 <form id="ajaxForm" enctype="multipart/form-data" class="modal-form"
                     action="{{ route('admin.package.store') }}" method="POST">
                     @csrf
                     <div class="form-group">
                         <label for="title">{{ __('Package title') . '*' }}</label>
                         <input id="title" type="text" class="form-control" name="title"
                             placeholder="{{ __('Enter Package title') }}" value="">
                         <p id="err_title" class="mt-2 mb-0 text-danger em"></p>
                     </div>
                     <div class="form-group">
                         <label for="price">{{ __('Price') }} ({{ $settings->base_currency_text }})*</label>
                         <input id="price" type="number" class="form-control" name="price"
                             placeholder="{{ __('Enter Package price') }}" value="">
                         <p class="text-warning">
                             <small>{{ __('If price is 0 , than it will appear as free') }}</small>
                         </p>
                         <p id="err_price" class="mt-2 mb-0 text-danger em"></p>
                     </div>

                     <div class="form-group">
                         <label for="">{{ __('Icon') . '*' }}</label>
                         <div class="btn-group d-block">
                             <button type="button" class="btn btn-primary iconpicker-component">
                                 <i class="fas fa-gift"></i>
                             </button>
                             <button type="button" class="icp icp-dd btn btn-primary dropdown-toggle"
                                 data-selected="fa-car" data-toggle="dropdown"></button>
                             <div class="dropdown-menu"></div>
                         </div>
                         <input type="hidden" id="inputIcon" name="icon">
                         <p id="err_icon" class="mt-2 mb-0 text-danger em"></p>
                     </div>

                     <div class="form-group">
                         <label for="term">{{ __('Package term') . '*' }}</label>
                         <select id="term" name="term" class="form-control" required>
                             <option value="" selected disabled>{{ __('Choose a Package term') }}</option>
                             <option value="monthly">{{ __('Monthly') }}</option>
                             <option value="yearly">{{ __('Yearly') }}</option>
                             <option value="lifetime">{{ __('Lifetime') }}</option>
                         </select>
                         <p id="err_term" class="mb-0 text-danger em"></p>
                     </div>


                     <div class="form-group">
                         <label class="form-label">{{ __('Package Features') }}</label>
                         <div class="selectgroup selectgroup-pills">
                             <label class="selectgroup-item">
                                 <input type="checkbox" name="features[]" value="Listing Enquiry Form"
                                     class="selectgroup-input">
                                 <span class="selectgroup-button">{{ __('Listing Enquiry Form') }}</span>
                             </label>
                             <label class="selectgroup-item">
                                 <input type="checkbox" name="features[]" value="Video" class="selectgroup-input">
                                 <span class="selectgroup-button">{{ __('Video') }}</span>
                             </label>

                             <label class="selectgroup-item">
                                 <input type="checkbox" name="features[]" value="Amenities" class="selectgroup-input">
                                 <span class="selectgroup-button">{{ __('Amenities') }}</span>
                             </label>
                             <label class="selectgroup-item">
                                 <input type="checkbox" name="features[]" value="Feature" class="selectgroup-input">
                                 <span class="selectgroup-button">{{ __('Features') }}</span>
                             </label>

                             <label class="selectgroup-item">
                                 <input type="checkbox" name="features[]" value="Social Links"
                                     class="selectgroup-input">
                                 <span class="selectgroup-button">{{ __('Social Links') }}</span>
                             </label>
                             <label class="selectgroup-item">
                                 <input type="checkbox" name="features[]" value="FAQ" class="selectgroup-input">
                                 <span class="selectgroup-button">{{ __('FAQ') }}</span>
                             </label>
                             <label class="selectgroup-item">
                                 <input type="checkbox" name="features[]" value="Business Hours"
                                     class="selectgroup-input">
                                 <span class="selectgroup-button">{{ __('Business Hours') }}</span>
                             </label>
                             <label class="selectgroup-item">
                                 <input type="checkbox" name="features[]" value="Products"
                                     class="selectgroup-input">
                                 <span class="selectgroup-button">{{ __('Products') }}</span>
                             </label>
                             <label class="selectgroup-item" id="productEnquiryFormLabel">
                                 <input type="checkbox" name="features[]" value="Product Enquiry Form"
                                     class="selectgroup-input">
                                 <span class="selectgroup-button">{{ __('Product Enquiry Form') }}</span>
                             </label>
                             <label class="selectgroup-item">
                                 <input type="checkbox" name="features[]" value="Messenger"
                                     class="selectgroup-input">
                                 <span class="selectgroup-button">{{ __('Messenger') }}</span>
                             </label>
                             <label class="selectgroup-item">
                                 <input type="checkbox" name="features[]" value="WhatsApp"
                                     class="selectgroup-input">
                                 <span class="selectgroup-button">{{ __('WhatsApp') }}</span>
                             </label>
                             <label class="selectgroup-item">
                                 <input type="checkbox" name="features[]" value="Telegram"
                                     class="selectgroup-input">
                                 <span class="selectgroup-button">{{ __('Telegram') }}</span>
                             </label>
                             <label class="selectgroup-item">
                                 <input type="checkbox" name="features[]" value="Tawk.To" class="selectgroup-input">
                                 <span class="selectgroup-button">{{ __('Tawk.To') }}</span>
                             </label>
                             <label class="selectgroup-item">
                                 <input type="checkbox" name="features[]" value="AI Content & Image Generator"
                                     class="selectgroup-input">
                                 <span class="selectgroup-button">{{ __('AI Content & Image Generator') }}</span>
                             </label>

                         </div>
                         <p id="err_features" class="mb-0 text-danger em"></p>
                     </div>
                     <div class="form-group">
                         <label class="form-label">{{ __('Number of Listings') . '*' }} </label>
                         <input type="number" class="form-control" name="number_of_listing"
                             placeholder="{{ __('Enter Number of Listings') }}">
                         <p class="text-warning">{{ __('Enter 999999 , then it will appear as unlimited') }}</p>
                         <p id="err_number_of_listing" class="mb-0 text-danger em"></p>
                     </div>
                     <div class="form-group">
                         <label class="form-label">{{ __('Number of image per Listing') . '*' }}</label>
                         <input type="number" class="form-control" name="number_of_images_per_listing"
                             placeholder="{{ __('Enter Number of image per Listing') }}">
                         <p class="text-warning">{{ __('Enter 999999 , then it will appear as unlimited') }}</p>
                         <p id="err_number_of_images_per_listing" class="mb-0 text-danger em"></p>
                     </div>

                     <div class="form-group amenities-box">
                         <label for="">{{ __('Number of Amenities per Listing') . '*' }} </label>
                         <input type="number" class="form-control" name="number_of_amenities_per_listing"
                             placeholder="{{ __('Enter Number of Amenities per Listing') }}">
                         <p class="text-warning">{{ __('Enter 999999 , then it will appear as unlimited') }}</p>
                         <p id="err_number_of_amenities_per_listing" class="mb-0 text-danger em"></p>
                     </div>
                     <div class="form-group additional-specification-box">
                         <label for="">{{ __('Number of Features per Listing') . '*' }} </label>
                         <input type="number" class="form-control" name="number_of_additional_specification"
                             placeholder="{{ __('Enter Number of Features per Listing') }}">
                         <p class="text-warning">{{ __('Enter 999999 , then it will appear as unlimited') }}</p>
                         <p id="err_number_of_additional_specification" class="mb-0 text-danger em"></p>
                     </div>

                     <div class="form-group social-links-box vcrd-none">
                         <label for="">{{ __('Number of Social Links per Listing') . '*' }} </label>
                         <input type="number" class="form-control" name="number_of_social_links"
                             placeholder="{{ __('Enter Number of Social Links per Listing') }}">
                         <p class="text-warning">{{ __('Enter 999999 , then it will appear as unlimited') }}</p>
                         <p id="err_number_of_social_links" class="mb-0 text-danger em"></p>
                     </div>
                     <div class="form-group FAQ-box">
                         <label for="">{{ __('Number of FAQs per Listing') . '*' }}</label>
                         <input type="number" class="form-control" name="number_of_faq"
                             placeholder="{{ __('Enter Number of FAQs per Listing') }}">
                         <p class="text-warning">{{ __('Enter 999999 , then it will appear as unlimited') }}</p>
                         <p id="err_number_of_faq" class="mb-0 text-danger em"></p>
                     </div>
                     <div class="form-group Products-box">
                         <label for="">{{ __('Number of Products') . '*' }} </label>
                         <input type="number" class="form-control" name="number_of_products"
                             placeholder="{{ __('Enter Number of Products') }}">
                         <p class="text-warning">{{ __('Enter 999999 , then it will appear as unlimited') }}</p>
                         <p id="err_number_of_products" class="mb-0 text-danger em"></p>
                     </div>
                     <div class="form-group image-product-box">
                         <label for="">{{ __('Number of Images per Product') . '*' }} </label>
                         <input type="number" class="form-control" name="number_of_images_per_products"
                             placeholder="{{ __('Enter Number of Images per Product') }}">
                         <p class="text-warning">{{ __('Enter 999999 , then it will appear as unlimited') }}</p>
                         <p id="err_number_of_images_per_products" class="mb-0 text-danger em"></p>
                     </div>
                     <div class="form-group">
                         <label for="status">{{ __('Status') . '*' }}</label>
                         <select id="status" class="form-control ltr" name="status">
                             <option value="" selected disabled>{{ __('Select a status') }}</option>
                             <option value="1">{{ __('Active') }}</option>
                             <option value="0">{{ __('Deactive') }}</option>
                         </select>
                         <p id="err_status" class="mb-0 text-danger em"></p>
                     </div>
                     <div class="form-group">
                         <label class="form-label">{{ __('Popular') }}</label>
                         <div class="selectgroup w-100">
                             <label class="selectgroup-item">
                                 <input type="radio" name="recommended" value="1" class="selectgroup-input">
                                 <span class="selectgroup-button">{{ __('Yes') }}</span>
                             </label>
                             <label class="selectgroup-item">
                                 <input type="radio" name="recommended" value="0" class="selectgroup-input"
                                     checked>
                                 <span class="selectgroup-button">{{ __('No') }}</span>
                             </label>
                         </div>
                     </div>

                     <div class="ai-feature-wrap d-none">
                         <div class=" p-3 mb-3  ai-feature-card">
                             <div class="row">
                                 <div class="col-md-6">
                                     <div class="form-group">
                                         <label for="ai_engine">{{ __('AI Engine') }} <span
                                                 class="text-danger">**</span></label>
                                         <select id="ai_engine" name="ai_engine" class="form-control">
                                             <option value="" selected disabled>{{ __('Choose AI Engine') }}</option>
                                             <option value="gemini">{{ __('Gemini') }}</option>
                                             <option value="openai">{{ __('OpenAI') }}</option>
                                         </select>
                                         <p id="errai_engine" class="mb-0 text-danger em"></p>
                                         <small class="text-info">
                                             {{ '*' . __('Select the AI engine that will power content and image generation for this package') . '.' }}
                                         </small>
                                     </div>
                                 </div>
                                 <div class="col-md-6">
                                     <div class="form-group">
                                         <label for="ai_token_limit">{{ __('Total AI Token Limit') }} <span
                                                 class="text-danger">**</span></label>
                                         <input id="ai_token_limit" type="number" class="form-control"
                                             name="ai_token_limit" placeholder="{{ __('Enter Total AI Token Limit') }}"
                                             value="">
                                         <p id="errai_token_limit" class="mb-0 text-danger em"></p>
                                         <small class="text-warning d-block">{{ __('Enter 999999 , then it will appear as unlimited') }}</small>
                                         <small class="text-info d-block">
                                             {{ '*' . __('Defines the total AI token usage allowed for this package for generating content') . '.' }}
                                         </small>
                                         <small class="text-warning d-block mt-2">
                                             {{ '*' . __('Minimum 20,000 tokens may be required for content generation') . '. ' . __('English content is usually cheaper, while other languages may consume more tokens and cost higher') . '. ' . __('For reference, 1K token approximately equal to USD 0.0015') . '.' }}
                                         </small>
                                     </div>
                                 </div>
                                 <div class="col-md-6">
                                     <div class="form-group">
                                         <label for="ai_image_limit">{{ __('Total AI Image Limit') }} <span
                                                 class="text-danger">**</span></label>
                                         <input id="ai_image_limit" type="number" class="form-control"
                                             name="ai_image_limit" placeholder="{{ __('Enter Total AI Image Limit') }}"
                                             value="">
                                         <p id="errai_image_limit" class="mb-0 text-danger em"></p>
                                         <small class="text-warning d-block">{{ __('Enter 999999 , then it will appear as unlimited') }}</small>
                                         <small class="text-info d-block">
                                             {{ '*' . __('This defines how many AI-generated images a vendor user can create under this package') . '.' }}
                                         </small>
                                         <small class="text-warning d-block">
                                             {{ '*' . __('Each AI image generation approximately costs USD 0.04 per image') . '.' }}
                                         </small>
                                     </div>
                                 </div>
                             </div>
                         </div>
                     </div>


                     <div class="form-group">
                         <label>{{ __('Custom Features') }}</label>
                         <textarea class="form-control" name="custom_features" rows="5"
                             placeholder="{{ __('Enter Custom Features') }}"></textarea>
                         <p class="text-warning">
                             <small>{{ __('Enter new line to seperate features') }}</small>
                         </p>
                     </div>


                 </form>
             </div>
             <div class="modal-footer">
                 <button type="button" class="btn btn-secondary" data-dismiss="modal">{{ __('Close') }}</button>
                 <button id="submitBtn" type="button" class="btn btn-primary">{{ __('Submit') }}</button>
             </div>
         </div>
     </div>
 </div>
