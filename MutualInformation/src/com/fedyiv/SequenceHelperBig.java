package com.fedyiv;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.math.RoundingMode;
import java.util.Random;

/**
 * Created by Ivan on 24.10.2015.
 */
public class SequenceHelperBig
{
    public BigInteger[]  convertBinarySequenceToDecimal(int [] binarySequence,int base)
    {
        BigInteger [] decimalSequence= new BigInteger[binarySequence.length/base];
        for(int i=0;i<binarySequence.length/base;i++)
        {
            String s="";
            for(int j=i*base;j<(i+1)*base;j++)
            {
                s=s+binarySequence[j];
            }
            decimalSequence[i]= new BigInteger(s,2);
        }
        return decimalSequence;
    }

    public BigDecimal calculateCorrelation(BigInteger []x,BigInteger [] y)
    {
        BigDecimal bigEX,bigEY,bigSX,bigSY;
        BigDecimal bigLength= new BigDecimal(x.length);

        bigEX=mathExpectation(x);
        bigEY=mathExpectation(y);

        bigSX=standardDeviation(x);
        bigSY=standardDeviation(y);

        BigDecimal bigSum=new BigDecimal(0);
        for(int i=0;i<x.length;i++)
        {
            BigDecimal xI= new BigDecimal(x[i]);
            BigDecimal yI= new BigDecimal(y[i]);

            bigSum=bigSum.add((xI.subtract(bigEX)).multiply(yI.subtract(bigEY)));


        }

        BigDecimal correlation=bigSum.divide((bigLength.subtract(BigDecimal.ONE)).multiply(bigSX.multiply(bigSY)), BigDecimal.ROUND_HALF_UP);

        return correlation;

    }

    public BigDecimal mathExpectation(BigInteger []x)
    {
        BigDecimal bigE=new BigDecimal(0);
        BigDecimal bigLength= new BigDecimal(x.length);
        for (int i=0;i<x.length;i++)
        {
            BigDecimal xI= new BigDecimal(x[i]);
            bigE = bigE.add( xI.divide(bigLength));
        }
        return bigE;
    }
    public BigDecimal standardDeviation(BigInteger []x)
    {
        BigDecimal bigE=mathExpectation(x);
        BigDecimal bigLength= new BigDecimal(x.length);
        BigDecimal bigSD=new BigDecimal(0);
        BigDecimal bigSum=new BigDecimal(0);


        for (int i=0;i<x.length;i++)
        {
            BigDecimal xI = new BigDecimal(x[i]);
            bigSum = bigSum.add( (xI.subtract( bigE)).pow(2));
        }
        bigSD=Util.sqrt(bigSum.divide((bigLength.subtract(BigDecimal.ONE)),BigDecimal.ROUND_HALF_UP), RoundingMode.HALF_UP);

        return bigSD;
    }



}
