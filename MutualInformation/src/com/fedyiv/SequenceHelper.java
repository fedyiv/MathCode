package com.fedyiv;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Random;

/**
 * Created by Ivan on 24.10.2015.
 */
public class SequenceHelper
{
    public double [] generateGaussianVector(int length)
    {
        Random rand=new Random();
        double[] x =new double[length];

        for (int i=0;i<length;i++)
        {
            x[i]=rand.nextGaussian();
        }
        return x;
    }
    public double [] generateCorrelatedVector(double [] x,double correlation)
    {
        Random rand=new Random();
        double[] e =new double[x.length];
        double[] y =new double[x.length];

        for (int i=0;i<x.length;i++)
        {
            e[i]=Math.sqrt(1-Math.pow(correlation,2))*rand.nextGaussian();
            y[i]=correlation*x[i]+e[i];
        }

        System.out.println("Target correlation=" + correlation);
        System.out.println("Actual correlation=" + calculateCorrelation(x,y));
        System.out.println("Actual variance=" + standardDeviation(y));

        return y;
    }
    public double calculateCorrelation(double []x,double [] y)
    {
        double ex,ey,sx,sy;

        ex=mathExpectation(x);
        ey=mathExpectation(y);

        sx=standardDeviation(x);
        sy=standardDeviation(y);

        double sum=0;
        for(int i=0;i<x.length;i++)
        {

            sum=sum+((x[i]-ex)*(y[i]-ey));


        }

        double correlation=sum/((x.length-1)*sx*sy);

        return correlation;

    }

    public double mathExpectation(double []x)
    {
        double e=0;
        for (int i=0;i<x.length;i++)
            e=e+x[i]/x.length;
        return e;
    }
    public double standardDeviation(double []x)
    {
        double e=mathExpectation(x);
        double sd=0;
        double sum=0;

        for (int i=0;i<x.length;i++)
            sum = sum+Math.pow((x[i]-e),2);
        sd=Math.sqrt(sum/(x.length-1));

        return sd;
    }

    public void saveDecimalSequence(double [] sequence,String fileName)
    {
        BufferedWriter out = null;
        try
        {
            FileWriter fstream = new FileWriter(fileName, false);
            out = new BufferedWriter(fstream);

            for (int i=0;i<sequence.length;i++)
            {
                out.write(sequence[i]+"\n");
            }
        }
        catch (IOException e)
        {
            System.err.println("Error: " + e.getMessage());
        }
        finally
        {
            try {
                if (out != null) {
                    out.close();
                }
            }
            catch(IOException e)
            {
                System.err.println("Error: " + e.getMessage());
            }
        }

    }

}
