################################################################################
### The following script is to show how to connect Ruby to R, and then produce #
### the output in an HTML document. It presents a simple linear regression     #
### example . The simulation parameters are defined in Ruby, computations are  #
### performed in R, and Ruby reports the result in an HTML document.           #
### An enhanced version of it would be to input the simulation parameters from  #
### a graphical user interface.                                                #
###                                                                            #
### Author: Abbass Al Sharif                                                   #
### Date  : April 15, 2008                                                     #
################################################################################

###################################################################
### RinRuby is a gem needed to connect Ruby to R.                 #
### Erubis is a gem that allows you to weave Ruby code into HTML  #
###################################################################
require "rinruby"
require "erubis"

#############################################
### Define the simulation parameter in Ruby #
#############################################
n = 10
beta_0 = 1
beta_1 = 0.25
alpha = 0.05
seed = 23423

####################################################################
### Assign an array of size n from Ruby to and R object called "x" #
####################################################################
R.x = (1..n).entries

###########################################################################
### The following chunck of code is going to be evaluated in R.           #
### Notice that you can pull data from Ruby to R using the "#{}" command. #
###########################################################################
R.eval <<EOF
  set.seed(#{seed})
  y <- #{beta_0} + #{beta_1}*x + rnorm(#{n})
  fit <-lm(y~x)
  est <-round(coef(fit),3)
  pvalue <-summary(fit)$coefficients[2,4]
EOF

##################################################################
### The following chunck of code is going to be evaluated in R.  #
### It produces a scatter plot for x and y, and saves it         #
##################################################################
R.eval <<EOF
jpeg("scatterplot.jpg", width=700, height=500)
plot(x,y, main = "Scatter plot that shows the relationship between x and y.")
abline(fit, col="red")
dev.off()
EOF

################################################################################
### The following is a template that makes use of the "Erubis" gem.            #
### It creates HTML code.                                                      #
### Notice that <%=...%> will excute Ruby code and inserts it into the output, #
### and <%...%> will just excute Ruby code.                                    #
################################################################################
template = "
<html>
<body>

  <center> <h1> Simple Linear Regression </h1></center>
  <hr size=\"2\" align=\"left\" width=\"100%\" color=\"GREEN\">
  <h3>E(y|x) ~= <%=#{R.est[0]}%> + <%= #{R.est[1]} %> * x </h3>

    <% if #{R.pvalue} < #{alpha} %>
         <p> Reject the null hypothesis and conclude that x and y are related.</p>
    <% else%>
         <p> There is insufficient evidence to conclude that x and y are related.</p>
    <% end %>
  
  <hr size=\"2\" align=\"left\" width=\"100%\" color=\"GREEN\">
  <center> <img src=\"scatterplot.jpg\" /> </center>

</body>
</html>
"
########################################################################################
### The following chunck of code puts the HTML code created in the template into an    #
### HTML file.Using the "Erubis" gem, we create and eruby_object by passing it the     #
### template created above as a string, and then use the object's evaluate method to   #
### get the output.                                                                    #
########################################################################################
f= File.open("output.html", 'w')

eruby_object= Erubis::Eruby.new(template)
eruby_object.evaluate()
f.write(eruby_object.evaluate())

f.close()
