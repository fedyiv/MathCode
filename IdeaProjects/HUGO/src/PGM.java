/**
 * Created with IntelliJ IDEA.
 * User: Ivan
 * Date: 14.07.13
 * Time: 15:02
 * To change this template use File | Settings | File Templates.
 */

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Scanner;


public class PGM {
    String Path;
    public String magicNumber;
    public int sizeX;
    public int sizeY;
    public int maxVal;
    public int[][] imageBitmap;

    public PGM(String Path) throws Exception {
        this.Path=Path;
        read();
    }

    public void  read() throws Exception {
        FileInputStream fileInputStream = null;
        try {
            fileInputStream = new FileInputStream(Path);
        } catch (FileNotFoundException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        Scanner scan = new Scanner(fileInputStream);

        String header = scan.nextLine();

        String[] tokens = header.split(" ");


        magicNumber= tokens[0];

        if(!magicNumber.equals("P5"))
            throw new Exception("Invalid format");
        sizeX = Integer.parseInt(tokens[1]);
        sizeY = Integer.parseInt(tokens[2]);
        maxVal = Integer.parseInt(tokens[3]);




        try {
            fileInputStream.close();
        } catch (IOException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }

        // Now parse the file as binary data
        fileInputStream = new FileInputStream(Path);
        DataInputStream dis = new DataInputStream(fileInputStream);

        //Skipping header
        int c=0;
        while (c!=10)
        {
            c=dis.readUnsignedByte();

        }



        // read the image data
        imageBitmap = new int[sizeY][sizeX];
        for (int row = 0; row < sizeY; row++) {
            for (int col = 0; col < sizeX; col++) {
                imageBitmap[row][col] = dis.readUnsignedByte();
              //  System.out.print(imageBitmap[row][col] + " ");
            }
          //  System.out.println();

        }

        fileInputStream.close();


    }

    public void  write(String Path) throws Exception {

        FileOutputStream fos= new FileOutputStream(Path);
        DataOutputStream dos = new DataOutputStream(fos);

        //dos.writeChars(magicNumber.toCharArray());
        dos.writeBytes(magicNumber);
        dos.writeByte(32);
        dos.writeBytes((new Integer(sizeX)).toString());
        dos.writeByte(32);
        dos.writeBytes((new Integer(sizeY)).toString());
        dos.writeByte(32);
        dos.writeBytes((new Integer(maxVal)).toString());
        dos.writeByte(10);

        for (int row = 0; row < sizeY; row++) {
            for (int col = 0; col < sizeX; col++) {
                 dos.writeByte(imageBitmap[row][col]);
            }

        }


        dos.flush();
        fos.close();

    }
}

