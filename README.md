# QuickTurn 2
AutoLisp Vehicle Tracking

This is a rewrite of QuickTurn to try and clean up the code a bit and add dynamic path creation

Purpose:  Model swept path of vehicles in 2D.

Notes:  Use "RunMe.cmd" to combine all necessary files to single "LoadQuickTurn2.lsp"

Status:

In Development...

All you need to run is "LoadQuickTurn2.lsp" unless you want to eval code.  If so copy the entire project and use "RunMe.cmd"

Background:

QuickTurn2 breaks the path into a series of short straightline segments.  For each straight line it calculates a new veehicle angle based on the previus angle (relative to the straight path segment).  The straight line formulae is defined by that found on page 2052 of:

Mathematical and Computer Modelling
Volume 49, Issues 9–10, May 2009, Pages 2049–2060
http://www.sciencedirect.com/science/article/pii/S0895717708003804

A second path is generated for the trailing vehicle based on the hitch point of the forward vehicle.  This process is repeated for additional vehicles.
