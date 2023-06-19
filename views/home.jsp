<%-- <%@page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="eStoreProduct.model.custCredModel" %>
<!DOCTYPE html>
<html>
<head>
  <title>SLAM Store</title>
 <script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  
   <style type="text/css">
   
       .profile-dropdown {
  position: relative;
  display: inline-block;
  transition: visibility;
  /* Add your desired background and text colors here */
  background-color: white;
  color: black;
}

.profile-dropdown:hover .dropdown-content {
  display: block;
  opacity: 1;
  transition: opacity 0.3s ease;
}

.dropdown-content {
  position: absolute;
  top: 100%;
  left: -60px; /* Adjust this value as per your preference */
  display: none;
  overflow: hidden;
  background-color: inherit; /* Set the background color to match the navbar */
  min-width: 120px;
  box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
  padding: 12px 10px;
  z-index: 1;
  opacity: 0;
  transition: opacity 0.3s ease;
  /* Add your desired background and text colors here */
  background-color: navy;
  color: black;
}

.dropdown-content a {
  display: block;
  margin-bottom: 5px;
  white-space: nowrap; /* Ensures the content stays in a single line */
  /* Add your desired text color here */
  color: black;
}

.profile-dropdown:hover .dropdown-content a:hover {
  /* Add your desired background color for hovered links here */
  background-color: white;
}

body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
    }    
   
    header {
  background-color:navy;
  color: #fff;
      padding: 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
}
       
    nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

nav ul {
  display: flex;
  align-items: center;
  list-style-type: none;
  margin: 0;
  padding: 0;
}

nav ul li {
  display: inline;
}

nav ul li:not(:last-child) {
  margin-right: 10px;
}

    nav ul li a {
      color: #fff;
      text-decoration: none;
      padding: 10px 20px;
    }
    nav ul li a:hover {
      background-color: #555;
    }
    .search-bar {
      text-align: center;
      padding: 20px;
      background-color: #f2f2f2;
    }    
    .search-bar input[type="text"] {
      width: 300px;
      padding: 6px;
      border: none;
    }   
    .search-bar input[type="submit"] {
      background-color: #333;
      color: #fff;
      border: none;
      padding: 6px 10px;
      cursor: pointer;
    }    
    .slideshow-container {
      position: relative;
      width: 100%;
      max-width: 800px;
      margin: 0 auto;
    }    
       
    .slideshow-container .slide {
      display: none;
    }  
    .slideshow-container .slide.active {
      display: block;
    }
    .slideshow-container img {
    width: 100%;
    height: 500px; /* Adjust the height as per your preference */
    object-fit: cover; 
       
   </style>

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
    $(document).ready(function() {
      function loadCategories() {
        loadAllProducts();
        $.ajax({
          url: "CategoriesServlet",
          method: 'GET',
          success: function(response) {
            $('#catg').html(response);
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
      }

      function loadAllProducts() {
        console.log("loadallproducts");
        $.ajax({
          url: "productsDisplay",
          method: 'GET',
          success: function(response) {
            $('#productsdisplay').html(response);
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
      }

      function addToCart(productId) {
        console.log("Add to cart called");
        $.ajax({
          url: "addToCart",
          method: 'GET',
          data: { productId: productId },
          success: function(response) {
            console.log("response " + response);
            console.log("added to cart");
            $('#display').html(response); // Set the response HTML as the inner HTML of the cart items element
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
      }

      function addToWishlist(productId) {
        console.log("Add to wishlist called");
        $.ajax({
          url: "addToWishlist",
          method: 'GET',
          data: { productId: productId },
          success: function(response) {
            $('#display').html(response); // Set the response HTML as the inner HTML of the cart items element
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
      }

      function removeFromCart(productId) {
        console.log("Remove from cart called");
        $.ajax({
          url: "removeFromCart",
          method: 'GET',
          data: { productId: productId },
          success: function(response) {
            showCart(); // Set the response HTML as the inner HTML of the cart items element
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
      }

      function removeFromWishlist(productId) {
        console.log("Remove from wishlist called");
        $.ajax({
          url: "removeFromWishlist",
          method: 'GET',
          data: { productId: productId },
          success: function(response) {
        	  showWishlist(); // Set the response HTML as the inner HTML of the cart items element
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
      }

      function showCart() {
        $.ajax({
          url: "cartItems",
          method: 'GET',
          data: { userId: 1 },
          success: function(response) {
        	  window.location.href = "cart.jsp";
        	  //$('#prod').html(response); // Set the response HTML as the inner HTML of the cart items element
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
      }

      function showWishlist() {
        $.ajax({
          url: "wishlistItems",
          method: 'GET',
          data: { userId: 1 },
          success: function(response) {
        	  console.log("response of wishlist "+response);
            $('#prod').html(response); // Set the response HTML as the inner HTML of the cart items element
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
      }
      function loadProductsByCategory() {
     	 console.log("category selected");
     	  //var category=
     		  console.log("category id selected "+document.getElementById("catg").value);
     	  $.ajax({
     	      url: "products",
     	      method: 'GET',
     	      data:{category:category},
     	      success: function(response) {
     	    	  console.log("response of category based prod "+response);
     	      
     	        $('#prod').html(response); // Set the response HTML as the inner HTML of the select element
     	      },
     	      error: function(xhr, status, error) {
     	        console.log('AJAX Error: ' + error);
     	      }
     	    });}


      // Call the loadCategories function when the page loads
      loadCategories();

      // Call the loadAllProducts function when the page loads
      loadAllProducts();

      // Add event listener for the "Add to Cart" button
      $(document).on('click', '.addToCartButton', function(event) {
        event.preventDefault();
        var productId = $(this).data('product-id');
        console.log(productId);
        addToCart(productId);
      });

      $(document).on('click', '.removeFromCart', function(event) {
        event.preventDefault();
        var productId = $(this).data('product-id');
        console.log(productId);
        removeFromCart(productId);
      });

      $(document).on('click', '.addToWishlistButton', function(event) {
        event.preventDefault();
        var productId = $(this).data('product-id');
        console.log(productId);
        addToWishlist(productId);
      });

      $(document).on('click', '.removeFromWishlist', function(event) {
        event.preventDefault();
        var productId = $(this).data('product-id');
        console.log(productId);
        removeFromWishlist(productId);
      });

      $('#catg').change(function() {
        loadProductsByCategory();
      });

      $('#cart-button').click(function() {
        showCart();
      });

      $('#Wishlist-button').click(function() {
        showWishlist();
      });

      var slides = $('.slide');
      var currentSlide = 0;

      // Function to show the current slide
      function showSlide() {
        // Hide all slides
        slides.hide();
        // Show the current slide
        slides.eq(currentSlide).show();
      }

      // Function to move to the next slide
      function nextSlide() {
        currentSlide++;
        if (currentSlide >= slides.length) {
          currentSlide = 0;
        }
        showSlide();
      }

      // Start the slideshow
      setInterval(nextSlide, 3000); // Change slide every 3 seconds
    });
  </script>
</head>
<body >
  <header>
  <h1>SLAM Store</h1>
  <nav>
    <ul>
      <li><a href="#">Home</a></li>
      <li><a href="#">About Us</a></li>
      <li><a href="#">Contact</a></li>
      <li>
        <form action="/process-category" method="POST">
          <select name="catg" id="catg"></select>
        </form>
      </li>
      <!-- <li><button type="button" id="cart-button" class="btn btn-primary" style="background-color: navy; color: white; font-weight: bold;">Cart</button></li>
       -->
       <li><a href="cartDisplay" class="btn btn-primary" style="background-color: navy; color: white; font-weight: bold;">Cart</a></li>
       <li><button type="button" id="Wishlist-button" class="btn btn-primary" style="background-color: navy; color: white; font-weight: bold;">Wishlist</button></li>
      <li class="profile-dropdown">
  <% if (!(Boolean) request.getAttribute("fl")) { %>
    <i class="fas fa-user-shield"></i>
    <div class="dropdown-content">
      <a href="signUp" style="background-color: navy; color: white; font-weight: bold;">Sign Up</a>
      <a href="signIn" style="background-color: navy; color: white; font-weight: bold;">Sign In</a>
    </div>
  <% } else { %>
    <i class="fas fa-user-shield"></i>
    <div class="dropdown-content">
      <a href="profilePage" style="background-color: navy; color: white; font-weight: bold;">My Profile</a>
    </div>
  <% } %>
</li>
      
    </ul>
  </nav>
</header>
  
  <div class="search-bar">
    <form>
      <input type="text" placeholder="Search...">
      <input type="submit" value="Search">
    </form>
  </div>
  <main>
  <div id="prod">
        <div id="transitionSlideShowPage">
                     <div class="slideshow-container">
                         <div class="slide active">
                             <img  src="https://static.digit.in/default/848e74e131ed5b8172357de25c0afb9bf691029c.jpeg?tr=w-1200" />
                         </div>
                         <div class="slide">
                             <img src="https://mobirise.com/extensions/commercem4/assets/images/3.jpg" alt="Slide 2">
                        </div>
                        <div class="slide">
                               <img src="https://t4.ftcdn.net/jpg/03/38/88/59/240_F_338885943_qQRG84nyD1CcTdXuVD4UbzMz1xBGWjBC.jpg" alt="Slide 3">
                        </div>
                        <div class="slide">
                                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRBQy58C3pHvO6tN7zHCeTqq4L2t2-Kc5ENA&usqp=CAU" alt="Slide 5">
                        </div>
                    </div>
       </div>
    <div id="productsdisplay"></div></div></main>
    
  <footer>
    <p>&copy; 2023 SLAM Store. All rights reserved.</p>
  </footer>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
  $(document).ready(function() {
    var slides = $('.slide');
    var currentSlide = 0;    
    // Function to show the current slide
    function showSlide() {
      // Hide all slides
      slides.hide();     
      // Show the current slide
      slides.eq(currentSlide).show();
    }    
    // Function to move to the next slide
    function nextSlide() {
      currentSlide++;
      if (currentSlide >= slides.length) {
        currentSlide = 0;
      }
      showSlide();
    }    
    // Start the slideshow
    setInterval(nextSlide, 3000); // Change slide every 3 seconds
  });
</script>
</body>
</html> --%><%@page import="org.springframework.ui.Model"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="eStoreProduct.model.custCredModel" %>
<!DOCTYPE html>
<html>
<head>
  <title>SLAM Store</title>
 <script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
  <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
  <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  
   <style type="text/css">
   
       .profile-dropdown {
  position: relative;
  display: inline-block;
  transition: visibility;
  /* Add your desired background and text colors here */
  background-color: white;
  color: black;
}

.profile-dropdown:hover .dropdown-content {
  display: block;
  opacity: 1;
  transition: opacity 0.3s ease;
}

.dropdown-content {
  position: absolute;
  top: 100%;
  left: -60px; /* Adjust this value as per your preference */
  display: none;
  overflow: hidden;
  background-color: inherit; /* Set the background color to match the navbar */
  min-width: 120px;
  box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
  padding: 12px 10px;
  z-index: 1;
  opacity: 0;
  transition: opacity 0.3s ease;
  /* Add your desired background and text colors here */
  background-color: navy;
  color: black;
}

.dropdown-content a {
  display: block;
  margin-bottom: 5px;
  white-space: nowrap; /* Ensures the content stays in a single line */
  /* Add your desired text color here */
  color: black;
}

.profile-dropdown:hover .dropdown-content a:hover {
  /* Add your desired background color for hovered links here */
  background-color: white;
}

body {
      margin: 0;
      padding: 0;
      display: flex;
      flex-direction: column;
      min-height: 100vh;
    }

    /* Set the main content to grow and fill the remaining vertical space */
    main {
      flex-grow: 1;
    }

    /* Footer styles */
    footer {
      background-color: navy;
      color: white;
      padding: 20px;
      text-align: center;
    }
   
    header {
  background-color:navy;
  color: #fff;
      padding: 20px;
      display: flex;
      justify-content: space-between;
      align-items: center;
}
       
    nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

nav ul {
  display: flex;
  align-items: center;
  list-style-type: none;
  margin: 0;
  padding: 0;
}

nav ul li {
  display: inline;
}

nav ul li:not(:last-child) {
  margin-right: 10px;
}

    nav ul li a {
      color: #fff;
      text-decoration: none;
      padding: 10px 20px;
    }
    nav ul li a:hover {
      background-color: #ffffff;
      text-decoration: none;
    }
    .search-bar {
      text-align: center;
      padding: 20px;
      background-color: #f2f2f2;
    }    
    .search-bar input[type="text"] {
      width: 300px;
      padding: 6px;
      border: none;
    }   
    .search-bar input[type="submit"] {
      background-color: #333;
      color: #fff;
      border: none;
      padding: 6px 10px;
      cursor: pointer;
    }    
    .slideshow-container {
      position: relative;
      width: 100%;
      max-width: 800px;
      margin: 0 auto;
    }    
       
    .slideshow-container .slide {
      display: none;
    }  
    .slideshow-container .slide.active {
      display: block;
    }
    .slideshow-container img {
    width: 100%;
    height: 500px; /* Adjust the height as per your preference */
    object-fit: cover; 
       
   </style>

  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  <script>
    $(document).ready(function() {
      function loadCategories() {
        loadAllProducts();
        $.ajax({
          url: "CategoriesServlet",
          method: 'GET',
          success: function(response) {
            $('#catg').html(response);
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
      }

      function loadAllProducts() {
        console.log("loadallproducts");
        $.ajax({
          url: "productsDisplay",
          method: 'GET',
          success: function(response) {
            $('#productsdisplay').html(response);
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
      }

      function addToCart(productId) {
        console.log("Add to cart called");
        $.ajax({
          url: "addToCart",
          method: 'GET',
          data: { productId: productId },
          success: function(response) {
            console.log("response " + response);
            console.log("added to cart");
            $('#display').html(response); // Set the response HTML as the inner HTML of the cart items element
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
      }

      function addToWishlist(productId) {
    	  <% if (!(Boolean) request.getAttribute("fl")) { %>
    	    window.location.href = "signIn";
    	 <% }
          else
          {%>
      
        console.log("Add to wishlist called");
        $.ajax({
          url: "addToWishlist",
          method: 'GET',
          data: { productId: productId },
          success: function(response) {
            $('#display').html(response); // Set the response HTML as the inner HTML of the cart items element
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
        <%}%>
      }

      function removeFromCart(productId) {
        console.log("Remove from cart called");
        $.ajax({
          url: "removeFromCart",
          method: 'GET',
          data: { productId: productId },
          success: function(response) {
        	  console.log("response of remove from cart "+response);
            showCart(); // Set the response HTML as the inner HTML of the cart items element
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
      }

      function removeFromWishlist(productId) {
        console.log("Remove from wishlist called");
        $.ajax({
          url: "removeFromWishlist",
          method: 'GET',
          data: { productId: productId },
          success: function(response) {
        	  showWishlist(); // Set the response HTML as the inner HTML of the cart items element
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
      }

      function showCart() {
        $.ajax({
          url: "cartItems",
          method: 'GET',
          data: { userId: 1 },
          success: function(response) {
        	 // window.location.href = "cart.jsp";
        	  $('#prod').html(response); // Set the response HTML as the inner HTML of the cart items element
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
      }

      function showWishlist() {
    	  <% if (!(Boolean) request.getAttribute("fl")) { %>
  	    window.location.href = "signIn";
  	 <% }
        else
        {%>
      
        $.ajax({
          url: "wishlistItems",
          method: 'GET',
          data: { userId: 1 },
          success: function(response) {
        	  console.log("response of wishlist "+response);
            $('#prod').html(response); // Set the response HTML as the inner HTML of the cart items element
          },
          error: function(xhr, status, error) {
            console.log('AJAX Error: ' + error);
          }
        });
        <%}%>

      }
      function loadProductsByCategory() {
     	 console.log("category selected");
     	  var category=document.getElementById("catg").value;
     	  console.log(category);
     	  $.ajax({
     		  url: "products",
     		  method: 'GET',
     		  data: { category_id: parseInt(category) },
     		  success: function(response) {
     		    console.log("response of category based prod " + response);
     		    $('#prod').html(response);
     		  },
     		  error: function(xhr, status, error) {
     		    console.log('AJAX Error: ' + error);
     		  }
     		});
 	}

       // Call the loadCategories function when the page loads
       loadCategories();

      // Call the loadAllProducts function when the page loads
      loadAllProducts();

      // Add event listener for the "Add to Cart" button
      $(document).on('click', '.addToCartButton', function(event) {
        event.preventDefault();
        var productId = $(this).data('product-id');
        console.log(productId);
        addToCart(productId);
      });

      $(document).on('click', '.removeFromCart', function(event) {
        event.preventDefault();
        var productId = $(this).data('product-id');
        console.log(productId);
        removeFromCart(productId);
      });

      $(document).on('click', '.addToWishlistButton', function(event) {
        event.preventDefault();
        var productId = $(this).data('product-id');
        console.log(productId);
        addToWishlist(productId);
      });

      $(document).on('click', '.removeFromWishlist', function(event) {
        event.preventDefault();
        var productId = $(this).data('product-id');
        console.log(productId);
        removeFromWishlist(productId);
      });

      $('#catg').change(function() {
        loadProductsByCategory();
      });

      $('#cart-button').click(function() {
        showCart();
      });

      $('#Wishlist-button').click(function() {
        showWishlist();
      });

      var slides = $('.slide');
      var currentSlide = 0;

      // Function to show the current slide
      function showSlide() {
        // Hide all slides
        slides.hide();
        // Show the current slide
        slides.eq(currentSlide).show();
      }

      // Function to move to the next slide
      function nextSlide() {
        currentSlide++;
        if (currentSlide >= slides.length) {
          currentSlide = 0;
        }
        showSlide();
      }

      // Start the slideshow
      setInterval(nextSlide, 3000); // Change slide every 3 seconds
    });
  
    function showProductDetails(productId) {
      	console.log("showproduct");   
      	$.ajax({
              type: "GET",
              url: "prodDescription",
              data: { productId: productId },
              success: function(response) {
              	 $('#prod').html(response);
              },
              error: function() {
                  alert("Error occurred while retrieving product details.");
              }
          });
      }
      
</script>
</head>
<body >
  <header>
  <h1>SLAM Store</h1>
  <nav>
    <ul>
      <li><a href="loggedIn" style="font-weight: bold;">Home</a></li>
      <li><a href="#" style="font-weight: bold;">About Us</a></li>
      <li><a href="#" style="font-weight: bold;">Contact</a></li>
      <li>
        <form action="/process-category" method="POST">
          <select name="catg" id="catg"></select>
        </form>
      </li>
      <li><button type="button" id="cart-button" class="btn btn-primary" style="background-color: navy; color: white; font-weight: bold;">Cart</button></li>
      
      <!--  <li><a href="cartDisplay" class="btn btn-primary" style="background-color: navy; color: white; font-weight: bold;">Cart</a></li> -->
       <li><button type="button" id="Wishlist-button" class="btn btn-primary" style="background-color: navy; color: white; font-weight: bold;">Wishlist</button></li>
      <li class="profile-dropdown">
  <% if (!(Boolean) request.getAttribute("fl")) { %>
    <i class="fas fa-user-shield"></i>
    <div class="dropdown-content">
      <a href="signUp" style="background-color: navy; color: white; font-weight: bold;">Sign Up</a>
      <a href="signIn" style="background-color: navy; color: white; font-weight: bold;">Sign In</a>
    </div>
  <% } else { %>
    <i class="fas fa-user-shield"></i>
    <div class="dropdown-content">
      <a href="profilePage" style="background-color: navy; color: white; font-weight: bold;">My Profile</a>
      <a href="logout" style="background-color: navy; color: white; font-weight: bold;">Logout</a>
    </div>
  <% } %>
</li>
      
    </ul>
  </nav>
</header>
  
  <div class="search-bar">
    <form>
      <input type="text" placeholder="Search...">
      <input type="submit" value="Search">
    </form>
  </div>
  <main>
  <div id="prod">
        <div id="transitionSlideShowPage">
                     <div class="slideshow-container">
                         <div class="slide active">
                             <img  src="https://static.digit.in/default/848e74e131ed5b8172357de25c0afb9bf691029c.jpeg?tr=w-1200" />
                         </div>
                         <div class="slide">
                             <img src="https://mobirise.com/extensions/commercem4/assets/images/3.jpg" alt="Slide 2">
                        </div>
                        <div class="slide">
                               <img src="https://t4.ftcdn.net/jpg/03/38/88/59/240_F_338885943_qQRG84nyD1CcTdXuVD4UbzMz1xBGWjBC.jpg" alt="Slide 3">
                        </div>
                        <div class="slide">
                                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRBQy58C3pHvO6tN7zHCeTqq4L2t2-Kc5ENA&usqp=CAU" alt="Slide 5">
                        </div>
                    </div>
       </div>
    <div id="productsdisplay"></div></div></main>
    
  <footer>
    <!-- <p>&copy; 2023 SLAM Store. All rights reserved.</p> -->
  </footer>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
  $(document).ready(function() {
    var slides = $('.slide');
    var currentSlide = 0;    
    // Function to show the current slide
    function showSlide() {
      // Hide all slides
      slides.hide();     
      // Show the current slide
      slides.eq(currentSlide).show();
    }    
    // Function to move to the next slide
    function nextSlide() {
      currentSlide++;
      if (currentSlide >= slides.length) {
        currentSlide = 0;
      }
      showSlide();
    }    
    // Start the slideshow
    setInterval(nextSlide, 3000); // Change slide every 3 seconds
  });
</script>
</body>
</html>