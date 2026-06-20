<?php

namespace App\Http\Controllers\FrontEnd;

use App\Http\Controllers\Controller;
use App\Models\BasicSettings\Basic;
use App\Models\Shop\Product;
use App\Models\Shop\ProductOrder;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\File\Exception\FileNotFoundException;
use Illuminate\Http\Request;

class OrderController extends Controller
{
    //index
    public function index()
    {
        $misc = new MiscellaneousController();

        $language = $misc->getLanguage();
        $information['bgImg'] = $misc->getBreadcrumb();
        $information['pageHeading'] = $misc->getPageHeading($language);

        $information['orders'] = ProductOrder::where('user_id', Auth::guard('web')->user()->id)->orderBy('id', 'desc')->get();
        return view('frontend.user.order.index', $information);
    }
    //details
    public function details($id)
    {
        $misc = new MiscellaneousController();

        $queryResult['bgImg'] = $misc->getBreadcrumb();

        $language = $misc->getLanguage();
        $queryResult['pageHeading'] = $misc->getPageHeading($language);

        $order = ProductOrder::query()->find($id);
        if ($order) {
            if ($order->user_id != Auth::guard('web')->user()->id) {
                return redirect()->route('user.dashboard');
            }

            $queryResult['order'] = $order;

            $queryResult['tax'] = Basic::select('product_tax_amount')->first();

            $items = $order->item()->get();

            $items->map(function ($item) use ($language) {
                $product = $item->productInfo()->first();
                $item['price'] = $product->current_price;
                $item['productType'] = $product->product_type;
                $item['inputType'] = $product->input_type;
                $item['link'] = $product->link;
                $content = $product->content()->where('language_id', $language->id)->first();

                $item['productTitle'] = $content ? $content->title : '';
                $item['slug'] =
                    $content ? $content->slug : '';
            });

            $queryResult['items'] = $items;

            return view('frontend.user.order.details', $queryResult);
        } else {
            return view('errors.404');
        }
    }
    public function downloadProduct(Request $request, $id)
    {
        $product = Product::query()->find($id);

        $pathToFile = public_path('./assets/file/products/' . $product->file);

        try {
            return response()->download($pathToFile);
        } catch (FileNotFoundException $e) {
            $request->session()->flash('error', 'Sorry, this file does not exist anymore!');

            return redirect()->back();
        }
    }
}
