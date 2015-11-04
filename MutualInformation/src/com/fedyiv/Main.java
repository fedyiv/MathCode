package com.fedyiv;

import java.io.FileInputStream;
import java.nio.file.Path;
import java.util.Arrays;
import java.util.Random;
import java.util.Scanner;

public class Main {

    public static void main(String[] args) {
	// write your code here
       // double [] x = new double[]{1,2,3,4,5,6,7,8,9,10};
        //double [] y = new double[]{1,2,100,4,5,6,7,8,9,10};

        int N=1000;
        int base=16;

        int[] plainMessage;
        int[] plainMessage2;
        int[] decryptedMessage;
        int[] secretKey;
        int[] encryptedMessage;
        int[] encryptedMessage2;

        SimpleCipher simpleCipher = new SimpleCipher();

        secretKey=simpleCipher.generateSecretKey();
        plainMessage=simpleCipher.generateRandomBitArray(base * N);
        plainMessage2=simpleCipher.generateRandomBitArray(base * N);


        simpleCipher.setSecretKey(secretKey);

        encryptedMessage=simpleCipher.encrypt(plainMessage);
        encryptedMessage2=simpleCipher.encrypt(plainMessage2);

        //     System.out.println("Encrypted message" + Arrays.toString(encryptedMessage));

        decryptedMessage=simpleCipher.decrypt(encryptedMessage);

        //      System.out.println("Decrypted message" + Arrays.toString(decryptedMessage));

        if (Arrays.equals(plainMessage, decryptedMessage))
        {
            System.out.println("Message was successfully decrypted");
        }
        else
        {
            System.out.println("ERROR: Failed to descrypt message");
            assert (false);

        }



        SequenceSaver sequenceSaver = new SequenceSaver();



        double []x;
        double []y;

        SequenceHelper sequenceHelper=new SequenceHelper();


        x = sequenceSaver.convertBinarySequenceToDecimal(plainMessage,base);
        y = sequenceSaver.convertBinarySequenceToDecimal(encryptedMessage, base);

        double correlation=sequenceHelper.calculateCorrelation(x,y);
        System.out.println("Correlation between (plainMessage,encryptedMessage) = " + correlation);


        x = sequenceSaver.convertBinarySequenceToDecimal(plainMessage2,base);
        y = sequenceSaver.convertBinarySequenceToDecimal(encryptedMessage, base);

        correlation=sequenceHelper.calculateCorrelation(x,y);
        System.out.println("Correlation between (plainMessage2,encryptedMessage) = " + correlation);


/*
        double mutualInformation;
        MutualInformationEstimator miEstimator = new MutualInformationEstimator();
        try {

            x = sequenceSaver.convertBinarySequenceToDecimal(plainMessage,base);
            y = sequenceSaver.convertBinarySequenceToDecimal(encryptedMessage,base);
            mutualInformation=miEstimator.estimate(x,y);
            System.out.println("Mutual information (plainMessage,encryptedMessage) = " + mutualInformation);

            x = sequenceSaver.convertBinarySequenceToDecimal(plainMessage,base);
            y = sequenceSaver.convertBinarySequenceToDecimal(plainMessage,base);
            mutualInformation=miEstimator.estimate(x,y);
            System.out.println("Mutual information (plainMessage,plainMessage) = " + mutualInformation);


            x = sequenceSaver.convertBinarySequenceToDecimal(plainMessage,base);
            y = sequenceSaver.convertBinarySequenceToDecimal(plainMessage2,base);
            mutualInformation=miEstimator.estimate(x,y);
            System.out.println("Mutual information (plainMessage,plainMessage2) = " + mutualInformation);


            x = sequenceSaver.convertBinarySequenceToDecimal(plainMessage2,base);
            y = sequenceSaver.convertBinarySequenceToDecimal(encryptedMessage,base);
            mutualInformation=miEstimator.estimate(x,y);
            System.out.println("Mutual information (plainMessage2,encryptedMessage) = " + mutualInformation);

            x = sequenceSaver.convertBinarySequenceToDecimal(plainMessage,base);
            y = sequenceSaver.convertBinarySequenceToDecimal(encryptedMessage2,base);
            mutualInformation=miEstimator.estimate(x,y);
            System.out.println("Mutual information (plainMessage,encryptedMessage2) = " + mutualInformation);

        }
        catch(Exception e)
        {
            e.printStackTrace();

        }
*/
    }

    public static double[] readSequenceFromFile(String fileName,int N)
    {
        try {
            Scanner scanner = new Scanner(new FileInputStream(fileName));
            double[] values = new double[N];
            int i = 0;
            while (scanner.hasNextLine() && i < N) {
                values[i] = Double.parseDouble(scanner.nextLine());

                i++;
            }
            return values;
        }
        catch(Exception e)
        {
            e.printStackTrace();
            return null;
        }

    }
}
