library(igraph)
library(rgl)
library(graph)
library(graphics)
############## igraph
#Samples of graphs formulas

g1 <- graph.formula(A:B) # 2 indepdent points :->no connection
plot(g1)

g2 <- graph.formula(A-B) # connecting points - ->connected
plot.igraph(g2)

g3 <- graph.formula(a:b - c:d) # 2 connected, 2 not
plot(g3)

g4 <-graph.formula(a-b,a-d) # a connects with both b & d , -> multiple connections
plot(g4)

g5 <- graph.formula(a-b,a-c-d, a:e)
plot(g5) # combination of all possible choices

##### Subset of my Facebook Friends, those who are related to me
fam.fb <-graph.formula(me-weston-justin,
	me-david-brooke-lauren-liz-sarah-tyler-justin,
	me-brooke-david-lauren-liz-tyler-justin,
	me-dezi-lauren-liz-zac,
	me-lauren-brooke-david-liz-sarah-tyler-dezi-justin-zac,
	me-liz-brooke-david-lauren-sarah-tyler-dezi-justin,
	me-sarah-david-lauren-liz-tyler,
	me-brooke-david-lauren-liz-sarah-justin,
	me-justin-weston-brooke-david-lauren-liz-tyler-zac,
	me-zac-dezi-justin-lauren)
# names of the nodes
V(fam.fb)$name

plot.igraph(fam.fb, main="Family Facebook Social Network - Me included") # when repeatedly run, the shape changes
leg.txt <-c("0-me", "1-Weston", "2-Justin", "3-David", "4-Brooke", 
	"5- Lauren", "6-Liz", "7-Sarah", "8-Tyler", "9-Dezi", "10-Zac")
legend(-1.7,1.3, leg.txt[0:12])

tkplot(fam.fb) # Change the veiw window and format -- clearer than plot.igraph
rglplot(fam.fb)

### taking the connection to me out
fam.fb2 <-graph.formula(weston-justin,
	david-brooke-lauren-liz-sarah-tyler-justin,
	brooke-david-lauren-liz-tyler-justin,
	dezi-lauren-liz-zac,
	lauren-brooke-david-liz-sarah-tyler-dezi-justin-zac,
	liz-brooke-david-lauren-sarah-tyler-dezi-justin,
	sarah-david-lauren-liz-tyler,
	brooke-david-lauren-liz-sarah-justin,
	justin-weston-brooke-david-lauren-liz-tyler-zac,
	zac-dezi-justin-lauren)
plot.igraph(fam.fb2, main="Family Facebook Social Network - me excluded")
leg.txt.2 <-c( "0-Weston", "1-Justin", "2-David", "3-Brooke", 
	"4- Lauren", "5-Liz", "6-Sarah", "7-Tyler", "8-Dezi", "9-Zac")
legend(-1.7,1.3, leg.txt.2[0:11])

tkplot(fam.fb2)
rglplot(fam.fb2)
