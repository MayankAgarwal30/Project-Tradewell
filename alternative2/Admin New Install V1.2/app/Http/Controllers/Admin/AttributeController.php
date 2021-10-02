<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Model\Attribute;
use Brian2694\Toastr\Facades\Toastr;
use Illuminate\Http\Request;

class AttributeController extends Controller
{
    function index()
    {
        $attributes = Attribute::orderBy('name')->paginate(10);
        return view('admin-views.attribute.index', compact('attributes'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required',
        ], [
            'name.required' => 'Name is required!',
        ]);

        $attribute = new Attribute;
        $attribute->name = $request->name;
        $attribute->save();
        Toastr::success('Attribute added successfully!');
        return back();
    }

    public function edit($id)
    {
        $attribute = Attribute::find($id);
        return view('admin-views.attribute.edit', compact('attribute'));
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'name' => 'required',
        ], [
            'name.required' => 'Name is required!',
        ]);

        $attribute = Attribute::find($id);
        $attribute->name = $request->name;
        $attribute->save();
        Toastr::success('Attribute updated successfully!');
        return back();
    }

    public function delete(Request $request)
    {
        $attribute = Attribute::find($request->id);
        $attribute->delete();
        Toastr::success('Attribute removed!');
        return back();
    }
}
