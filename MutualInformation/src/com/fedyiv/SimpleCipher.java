package com.fedyiv;

import java.util.Arrays;
import java.util.Random;

/**
 * Created by Ivan on 21.08.2015.
 */
public class SimpleCipher {
    private int [] secretKey;
    private int [][]roundKeys;

    public void setSecretKey(int []secretKey)
    {
        this.secretKey=secretKey;

        System.out.println("Generating round keys");

        roundKeys = new int[5][16];
        for (int i=0;i<5;i++)
        {
            System.arraycopy(secretKey,i*16,roundKeys[i],0,16);
            System.out.println(Arrays.toString(roundKeys[i]));
        }



    }
    public int [] encrypt(int [] plainMessage)
    {
        int [] encryptedMessage= new int[plainMessage.length];

        for (int i=0;i<plainMessage.length/16;i++)
        {
            int [] plainBlock=new int[16];
            int [] encryptedBlock=new int[16];
            System.arraycopy(plainMessage,i*16,plainBlock,0,16);
            encryptedBlock=encryptBlock(plainBlock);
            System.arraycopy(encryptedBlock, 0, encryptedMessage, i * 16, 16);

        }

        return encryptedMessage;
    }

    public int [] decrypt(int [] encryptedMessage)
    {
        int [] plainMessage= new int[encryptedMessage.length];

        for (int i=0;i<encryptedMessage.length/16;i++)
        {
            int [] encryptedBlock=new int[16];
            int [] plainBlock=new int[16];
            System.arraycopy(encryptedMessage,i*16,encryptedBlock,0,16);
            plainBlock=decryptBlock(encryptedBlock);
            System.arraycopy(plainBlock, 0, plainMessage, i * 16, 16);
        }

        return plainMessage;
    }

    private int [] encryptBlock(int [] inputBlock)
    {
        int [] outputBlock= new int[inputBlock.length];
        int [] roundBlock= new int[inputBlock.length];

        RoundEncryptorDecryptor roundEncryptor = new RoundEncryptorDecryptor();

        System.arraycopy(inputBlock,0,roundBlock,0,inputBlock.length);
      //  System.out.println("ENCRYPTION: Input message" + Arrays.toString(inputBlock));
        for(int i=0;i<4;i++) {
            roundEncryptor.setRoundKey(roundKeys[i]);
            roundBlock = roundEncryptor.encryptRound(roundBlock);
        //    System.out.println("ENCRYPTION: Message after round " + i + ":" + Arrays.toString(roundBlock));
        }

        roundEncryptor.setRoundKey(roundKeys[4]);
        outputBlock=roundEncryptor.addRoundKey(roundBlock);
     //   System.out.println("ENCRYPTION: Message after addition round 5 key  :" + Arrays.toString(outputBlock));

        return outputBlock;

    }

    private int [] decryptBlock(int [] inputBlock)
    {
        int [] outputBlock= new int[inputBlock.length];
        int [] roundBlock= new int[inputBlock.length];

        RoundEncryptorDecryptor roundDecryptor = new RoundEncryptorDecryptor();

     //   System.out.println("DECRYPTION: Input message" + Arrays.toString(inputBlock));

        roundDecryptor.setRoundKey(roundKeys[4]);
        roundBlock= roundDecryptor.addRoundKey(inputBlock);

     //   System.out.println("DECRYPTION: Message after addition round 4 key  :" + Arrays.toString(roundBlock));


        for(int i=3;i>=0;i--) {
            roundDecryptor.setRoundKey(roundKeys[i]);
            roundBlock = roundDecryptor.decryptRound(roundBlock);
   //         System.out.println("DECRYPTION: Message after round " + i + ":" + Arrays.toString(roundBlock));
        }

        outputBlock=roundBlock;

        return outputBlock;

    }


    private class RoundEncryptorDecryptor
    {
        private int [] roundKey;
        private Integer [][] permutateTable;
        private Integer [][] sBlockTable;

        public RoundEncryptorDecryptor()
        {
            //Creating table for permutation
            permutateTable=new Integer[2][16];
            //Coulmn 0 - input values for encryption
            //Column 1 - output values for encryption

            permutateTable[0][0]=1;
            permutateTable[1][0]=1;

            permutateTable[0][1]=2;
            permutateTable[1][1]=5;

            permutateTable[0][2]=3;
            permutateTable[1][2]=9;

            permutateTable[0][3]=4;
            permutateTable[1][3]=13;

            permutateTable[0][4]=5;
            permutateTable[1][4]=2;

            permutateTable[0][5]=6;
            permutateTable[1][5]=6;

            permutateTable[0][6]=7;
            permutateTable[1][6]=10;

            permutateTable[0][7]=8;
            permutateTable[1][7]=14;

            permutateTable[0][8]=9;
            permutateTable[1][8]=3;

            permutateTable[0][9]=10;
            permutateTable[1][9]=7;

            permutateTable[0][10]=11;
            permutateTable[1][10]=11;

            permutateTable[0][11]=12;
            permutateTable[1][11]=15;

            permutateTable[0][12]=13;
            permutateTable[1][12]=4;

            permutateTable[0][13]=14;
            permutateTable[1][13]=8;

            permutateTable[0][14]=15;
            permutateTable[1][14]=12;

            permutateTable[0][15]=16;
            permutateTable[1][15]=16;


            /*Creating table for S-Block Transformmation
            Coulmn 0 - input values for encryption
            Column 1 - output values for encryption*/

            sBlockTable=new Integer[2][16];

            sBlockTable[0][0]=0x0;
            sBlockTable[1][0]=0xE;

            sBlockTable[0][1]=0x1;
            sBlockTable[1][1]=0x4;

            sBlockTable[0][2]=0x2;
            sBlockTable[1][2]=0xD;

            sBlockTable[0][3]=0x3;
            sBlockTable[1][3]=0x1;

            sBlockTable[0][4]=0x4;
            sBlockTable[1][4]=0x2;

            sBlockTable[0][5]=0x5;
            sBlockTable[1][5]=0xF;

            sBlockTable[0][6]=0x6;
            sBlockTable[1][6]=0xB;

            sBlockTable[0][7]=0x7;
            sBlockTable[1][7]=0x8;

            sBlockTable[0][8]=0x8;
            sBlockTable[1][8]=0x3;

            sBlockTable[0][9]=0x9;
            sBlockTable[1][9]=0xA;

            sBlockTable[0][10]=0xA;
            sBlockTable[1][10]=0x6;

            sBlockTable[0][11]=0xB;
            sBlockTable[1][11]=0xC;

            sBlockTable[0][12]=0xC;
            sBlockTable[1][12]=0x5;

            sBlockTable[0][13]=0xD;
            sBlockTable[1][13]=0x9;

            sBlockTable[0][14]=0xE;
            sBlockTable[1][14]=0x0;

            sBlockTable[0][15]=0xF;
            sBlockTable[1][15]=0x7;

        }

        public void setRoundKey(int [] roundKey)
        {
            this.roundKey=roundKey;
        }

        public int [] encryptRound(int [] roundInput)
        {
            int []roundOutput;
            int [] internalRoundChain;

   //         System.out.println("encryptRound: Input round message" + Arrays.toString(roundInput));
   //         System.out.println("encryptionRound: round key:" + Arrays.toString(roundKey));
            internalRoundChain=addRoundKey(roundInput);

   //         System.out.println("encryptRound: Before s-Blocks Transformation" + Arrays.toString(internalRoundChain));
            internalRoundChain= sBlocksTransformationEncryption(internalRoundChain);

   //         System.out.println("encryptRound:Before permutation" + Arrays.toString(internalRoundChain));
            internalRoundChain= permutateRoundEncryption(internalRoundChain);
  //          System.out.println("encryptRound:After permutation" + Arrays.toString(internalRoundChain));

            roundOutput=internalRoundChain;
            return roundOutput;
        }

        public int [] decryptRound(int [] roundInput)
        {
            int []roundOutput;
            int [] internalRoundChain;

    //        System.out.println("decryptRound: Input round message" + Arrays.toString(roundInput));
  //          System.out.println("decryptRound: round key:" + Arrays.toString(roundKey));

            internalRoundChain= permutateRoundDecryption(roundInput);
    //        System.out.println("decryptRound: Before s-Blocks Transformation" + Arrays.toString(internalRoundChain));
            internalRoundChain= sBlocksTransformationDecryption(internalRoundChain);
   //         System.out.println("decryptRound: After s-Blocks Transformation" + Arrays.toString(internalRoundChain));
            internalRoundChain=addRoundKey(internalRoundChain);
    //        System.out.println("decryptRound: After adding round key" + Arrays.toString(internalRoundChain));

            roundOutput=internalRoundChain;


            return roundOutput;
        }

        public int [] addRoundKey(int [] input)
        {
            int [] output = new int[input.length];
            for(int i=0;i<input.length;i++)
                output[i]=(input[i]+roundKey[i])%2;

            return output;
        }

        private int [] permutateRoundEncryption(int[] input)
        {
            int [] output = new int[input.length];
            for(int i=0;i<input.length;i++)
                output[i]=input[permutateTableForEncryption(i+1)-1];

            return output;
        }
        private int [] permutateRoundDecryption(int[] input)
        {
            int [] output = new int[input.length];
            for(int i=0;i<input.length;i++)
                output[i]=input[permutateTableForDecryption(i + 1)-1];

            return output;
        }

        private int [] sBlocksTransformationEncryption(int[] input)
        {
            int [] output = new int[input.length];
            int [] partialArrayForSBlock=new int[4];
            for(int i=0;i<input.length/4;i++) {
                System.arraycopy(input,i*4,partialArrayForSBlock,0,4);
                System.arraycopy(sBlockTransformationEncryption(partialArrayForSBlock), 0, output, i * 4, 4);
            }

            return output;
        }

        private int [] sBlocksTransformationDecryption(int[] input)
        {
            int [] output = new int[input.length];
            int [] partialArrayForSBlock=new int[4];
            for(int i=0;i<input.length/4;i++) {
                System.arraycopy(input,i*4,partialArrayForSBlock,0,4);
                System.arraycopy(sBlockTransformationDecryption(partialArrayForSBlock), 0, output, i * 4, 4);
            }

            return output;
        }

        private int [] sBlockTransformationEncryption(int[] input)
        {
            int [] output = new int[input.length];
            String bitChain= new String();

            for(int i=0;i<input.length;i++)
                bitChain=bitChain+input[i];

            int inputDecimal=Integer.parseInt(bitChain,2);

            int index=java.util.Arrays.asList(sBlockTable[0]).indexOf(inputDecimal);

            int outputDecimal=sBlockTable[1][index];
            String outpuBinaryString=Integer.toBinaryString(outputDecimal);
            outpuBinaryString=String.format("%4s",outpuBinaryString).replace(' ','0');

            for(int i=0;i<outpuBinaryString.length();i++)
                output[i]=Character.getNumericValue(outpuBinaryString.charAt(i));

            return output;

        }


        private int permutateTableForEncryption(int inputValue)
        {
            int outputValue;

            int index=java.util.Arrays.asList(permutateTable[1]).indexOf(inputValue);



            outputValue=permutateTable[0][index];
            return outputValue;
        }

        private int permutateTableForDecryption(int inputValue)
        {
            int outputValue;

            int index=java.util.Arrays.asList(permutateTable[0]).indexOf(inputValue);



            outputValue=permutateTable[1][index];
            return outputValue;
        }

        private int [] sBlockTransformationDecryption(int[] input)
        {
            int [] output = new int[input.length];
            String bitChain= new String();

            for(int i=0;i<input.length;i++)
                bitChain=bitChain+input[i];

            int inputDecimal=Integer.parseInt(bitChain,2);

            int index=java.util.Arrays.asList(sBlockTable[1]).indexOf(inputDecimal);

            int outputDecimal=sBlockTable[0][index];
            String outpuBinaryString=Integer.toBinaryString(outputDecimal);
            outpuBinaryString=String.format("%4s",outpuBinaryString).replace(' ','0');

            for(int i=0;i<outpuBinaryString.length();i++)
                output[i]=Character.getNumericValue(outpuBinaryString.charAt(i));

            return output;

        }
    }

    public static int [] generateSecretKey()
    {
        return generateRandomBitArray(80);
    }

    public static int [] generateRandomBitArray(int length)
    {
        int[] bitArray = new int[length];
        Random randomKeyGenerator = new Random(System.currentTimeMillis());

        for (int i=0;i<bitArray.length;i++)
        {
            //bitArray[i]=Math.abs(randomKeyGenerator.nextInt())%2;
            bitArray[i]=Math.abs((int)randomKeyGenerator.nextGaussian())%2;
        }

        return bitArray;
    }
}
