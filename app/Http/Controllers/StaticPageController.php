<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use RalphJSmit\Laravel\SEO\Support\SEOData;

class StaticPageController extends Controller
{
     public function about()
    {
		$SEOData = new SEOData(
            title: "About Us",
            description: "Discover the mission and vision behind Study Nexus. Learn more about our commitment to enhancing educational access and success.",
        );
		
        return view('about', compact('SEOData'));  
    }
	
	 public function policy()
    {
		$SEOData = new SEOData(
            title: "Privacy Policy",
            description: "Understand how Study Nexus collects, uses and safeguards your personal information. Read our detailed policy to stay informed.",
        );
		
        return view('policy' , compact('SEOData'));  
    }
	
	 public function terms()
    {
		$SEOData = new SEOData(
            title: "Terms of Service",
            description: "Review the terms and conditions that govern the use of Study Nexus. Learn about your rights and responsibilities while using our platform.",
        );
		
        return view('terms' , compact('SEOData'));  
    }
	
	 public function contact()
    {
		$SEOData = new SEOData(
            title: "Contact Us",
            description: "Get in touch with the 'Study Nexus' team for any inquiries, support, or feedback.",
        );
		
        return view('contact' , compact('SEOData'));  
    }
}
