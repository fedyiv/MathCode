package com.fedyiv;

import java.util.Arrays;

/**
 * Created by Ivan on 20.10.2015.
 */
public class MutualInformationEstimator {
    private ZPoint [] zPointArray;
    private final int k=1;

    private class ZPoint{
        private double  x;
        private double  y;
        private int nearestNeighbourAddress;
        private double distanceToTheNearestNeighbour;
        private int nX;
        private int nY;

        private double getDistanceToANeighbour(ZPoint aNeighbour)
        {
            double xDistance,yDistance,zDistance;
            xDistance=Math.abs(this.x-aNeighbour.x);
            yDistance=Math.abs(this.y - aNeighbour.y);
            zDistance=Math.max(xDistance,yDistance);

            return zDistance;
        }
        private double getXDistanceToANeighbour(ZPoint aNeighbour)
        {
            return (Math.abs(this.x-aNeighbour.x));
        }
        private double getYDistanceToANeighbour(ZPoint aNeighbour)
        {
            return (Math.abs(this.y-aNeighbour.y));
        }
    }


    private double digamma(double input)
    {
        final double C=0.577215664901532860606512090082;
        // Fast calculation for large inputs
        if(input>900)
        {
            return Math.log(input)-1/(2*input)-1/(12*input*input);
        }

        if(input==1)
            return -C;
        else
            return digamma(input-1)+1/(input-1);
    }

    public double estimate(double []x,double []y) throws Exception
    {
        if(x.length!=y.length)
        {
            throw new Exception("Currently it is assumed that both vectors must have the same length");
        }

        zPointArray=new ZPoint[x.length];

        for (int i=0;i<x.length;i++)
        {
            zPointArray[i]= new ZPoint();
            zPointArray[i].x=x[i];
            zPointArray[i].y=y[i];
            zPointArray[i].nearestNeighbourAddress=-1;
            zPointArray[i].distanceToTheNearestNeighbour=Double.MAX_VALUE;
        }

        for (int i=0;i<x.length;i++)
        {
            for (int j=0;j<x.length;j++)
            {
                //if(j==i) - initial slow way
                if (j<=i)
                    continue;
                double zDistance;

                zDistance=zPointArray[i].getDistanceToANeighbour(zPointArray[j]);

                if(zDistance<zPointArray[i].distanceToTheNearestNeighbour)
                {
                    zPointArray[i].distanceToTheNearestNeighbour=zDistance;
                    zPointArray[i].nearestNeighbourAddress=j;
                }
                /* another half of speeding up*/
                if(zDistance<zPointArray[j].distanceToTheNearestNeighbour)
                {
                    zPointArray[j].distanceToTheNearestNeighbour=zDistance;
                    zPointArray[j].nearestNeighbourAddress=i;
                }
            }
        }


        for (int i=0;i<x.length;i++)
        {
            int nX=0;
            int nY=0;

            for (int j=0;j<x.length;j++)
            {
                if (i==j)
                    continue;

                if (zPointArray[i].getXDistanceToANeighbour(zPointArray[j])<zPointArray[i].distanceToTheNearestNeighbour)
                {
                    nX++;
                }

                if (zPointArray[i].getYDistanceToANeighbour(zPointArray[j])<zPointArray[i].distanceToTheNearestNeighbour)
                {
                    nY++;
                }


            }
            zPointArray[i].nX=nX;
            zPointArray[i].nY=nY;

        }


        double auxilarySum=0;
        for (int i=0;i<x.length;i++)
        {
            auxilarySum=auxilarySum+(digamma(zPointArray[i].nX+1)+digamma(zPointArray[i].nY+1))/x.length;
        }
       // System.out.println("Digamma(k)="+digamma(k)+" auxilarySum="+auxilarySum+" digamma(N)="+digamma(x.length));

        double mutualInformation=digamma(k)-auxilarySum+digamma(x.length);


        return mutualInformation;
    }
}
