<?php

namespace App\Http\Controllers\FrontEnd;

use App\Http\Controllers\Controller;
use App\Http\Controllers\FrontEnd\MiscellaneousController;
use App\Models\CustomPage\Page;
use App\Models\CustomPage\PageContent;

class PageController extends Controller
{
  public function page($slug)
  {
    $misc = new MiscellaneousController();

    $language = $misc->getLanguage();

    $information['bgImg'] = $misc->getBreadcrumb();

    $id = PageContent::Where('slug', $slug)->firstorFail();

    $information['pageInfo'] = Page::join('page_contents', 'pages.id', '=', 'page_contents.page_id')
      ->where('pages.status', '=', 1)
      ->where('page_contents.language_id', '=', $language->id)
      ->where('page_contents.page_id', '=', $id->page_id)
      ->findOrFail($id->page_id);
    return view('frontend.custom-page', $information);
  }
}
