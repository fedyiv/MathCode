package com.fedyiv;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.math.BigInteger;
import java.util.Random;

/**
 * Created by Ivan on 02.09.2015.
 */
public class SequenceSaver {

    public void saveDecimalSequence(double [] sequence,String fileName)
    {
        BufferedWriter out = null;
        try
        {
            FileWriter fstream = new FileWriter(fileName, false);
            out = new BufferedWriter(fstream);

            for (int i=0;i<sequence.length;i++)
            {
                out.write(((float)sequence[i])+"\n");
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

    public double[]  convertBinarySequenceToDecimal(int [] binarySequence,int base)
    {
        double [] decimalSequence= new double[binarySequence.length/base];
        for(int i=0;i<binarySequence.length/base;i++)
        {
            String s="";
            for(int j=i*base;j<(i+1)*base;j++)
            {
                s=s+binarySequence[j];
            }
            decimalSequence[i]=Integer.parseInt(s,2);
        }
        return decimalSequence;
    }


    public void saveBinarySequenceAsDecimal(int [] binarySequence,int base,String fileName)
    {
        saveDecimalSequence(convertBinarySequenceToDecimal(binarySequence,base),fileName);
        saveDecimalSequence(generateCorrelatedSequence(convertBinarySequenceToDecimal(binarySequence,base)),fileName+"Correlated");
    }

    private double[]  generateCorrelatedSequence(double[] inSequence)
    {
        Random randomGenerator=new Random();
        int noise;
        double [] outSequence=new double[inSequence.length];

        for(int i=0;i<inSequence.length;i++)
        {
            noise=(int)(Math.round(10*randomGenerator.nextGaussian()));
            outSequence[i]=inSequence[i]+noise;
        }

        return(outSequence);
    }
}
