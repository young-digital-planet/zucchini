package pl.ydp.automation.execution.storage.snapshot.algorithm.impl
{
	import flash.display.BitmapData;
	
	import pl.ydp.automation.execution.storage.snapshot.algorithm.IComparisonAlgorithm;
	
	
	public class HashComparisonAlgorithm implements IComparisonAlgorithm
	{
		public function HashComparisonAlgorithm()
		{
		}
		
		public function compare(bitmapDataA:BitmapData, bitmapDataB:BitmapData):*
		{
			var imageHash:ImagePHash = new ImagePHash();
			var firstHash:String = imageHash.getHash(bitmapDataA);
			var secondHash:String = imageHash.getHash(bitmapDataB);
			var distance:int = imageHash.distance(firstHash, secondHash);
			return distance;
		}
	}
}
/*
* Originally written in Java by: Elliot Shepherd (elliot@jarofworms.com
* AS3 version: Pawel Lewandowski
* Based On: http://www.hackerfactor.com/blog/index.php?/archives/432-Looks-Like-It.html
*/

import flash.display.BitmapData;
import flash.filters.ColorMatrixFilter;
import flash.geom.Matrix;
import flash.geom.Point;
import flash.geom.Rectangle;

class ImagePHash {
	
	private var size:int;
	private var smallerSize:int;
	
	public function ImagePHash(size:int = 32, smallerSize:int = 8) {
		this.size = size;
		this.smallerSize = smallerSize;
		
		initCoefficients();
	}
	
	public function distance(s1:String, s2:String):int {
		var counter:int = 0;
		for (var k:int = 0; k < s1.length; k++) {
			if(s1.charAt(k) != s2.charAt(k)) {
				counter++;
			}
		}
		return counter;
	}
	
	// Returns a 'binary string' (like. 001010111011100010) which is easy to do a hamming distance on. 
	public function getHash(img:BitmapData):String {
		/* 1. Reduce size. 
		* Like Average Hash, pHash starts with a small image. 
		* However, the image is larger than 8x8; 32x32 is a good size. 
		* This is really done to simplify the DCT computation and not 
		* because it is needed to reduce the high frequencies.
		*/
		img = resize(img, size, size);
		
		/* 2. Reduce color. 
		* The image is reduced to a grayscale just to further simplify 
		* the number of computations.
		*/
		img = grayscale(img);
		
		var vals:Array = [size];
		for (var i:int = 0; i < size; i++) {
			vals[i] = [size];
		}
		
		for (var x:int = 0; x < img.width; x++) {
			for (var y:int = 0; y < img.height; y++) {
				vals[x][y] = getPixel(img, x, y);
			}
		}
		
		/* 3. Compute the DCT. 
		* The DCT separates the image into a collection of frequencies 
		* and scalars. While JPEG uses an 8x8 DCT, this algorithm uses 
		* a 32x32 DCT.
		*/
		var date:Date = new Date();
		var start:Number = date.time;
		var dctVals:Array = applyDCT(vals);
		//System.out.println("DCT: " + (System.currentTimeMillis() - start));
		
		/* 4. Reduce the DCT. 
		* This is the magic step. While the DCT is 32x32, just keep the 
		* top-left 8x8. Those represent the lowest frequencies in the 
		* picture.
		*/
		/* 5. Compute the average value. 
		* Like the Average Hash, compute the mean DCT value (using only 
		* the 8x8 DCT low-frequency values and excluding the first term 
		* since the DC coefficient can be significantly different from 
		* the other values and will throw off the average).
		*/
		var total:Number = 0;
		
		for (x = 0; x < smallerSize; x++) {
			for (y = 0; y < smallerSize; y++) {
				total += dctVals[x][y];
			}
		}
		total -= dctVals[0][0];
		
		var avg:Number = total / (smallerSize * smallerSize) - 1;
		
		/* 6. Further reduce the DCT. 
		* This is the magic step. Set the 64 hash bits to 0 or 1 
		* depending on whether each of the 64 DCT values is above or 
		* below the average value. The result doesn't tell us the 
		* actual low frequencies; it just tells us the very-rough 
		* relative scale of the frequencies to the mean. The result 
		* will not vary as long as the overall structure of the image 
		* remains the same; this can survive gamma and color histogram 
		* adjustments without a problem.
		*/
		var hash:String = "";
		
		for (x = 0; x < smallerSize; x++) {
			for (y = 0; y < smallerSize; y++) {
				if (x != 0 && y != 0) {
					hash += (dctVals[x][y] > avg?"1":"0");
				}
			}
		}
		
		return hash;
	}
	
	private function resize(image:BitmapData, width:int, height:int):BitmapData {
		var mat:Matrix = new Matrix();
		mat.scale(width/image.width, height/image.height);
		var resizedImage:BitmapData = new BitmapData(width, height, false);
		resizedImage.draw(image, mat, null, null, null, true);
		return resizedImage;
	}
	
	private function grayscale(img:BitmapData):BitmapData {
		// Turn the object graphics to greyscale.
		var matrix:Array = new Array();
		matrix = matrix.concat([0.33, 0.33, 0.33, 0, 0]); // red
		matrix = matrix.concat([0.33, 0.33, 0.33, 0, 0]); // green
		matrix = matrix.concat([0.33, 0.33, 0.33, 0, 0]); // blue
		matrix = matrix.concat([0, 0, 0, 1, 0]); // alpha
		
		var filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
		
		img.applyFilter(img, new Rectangle(0, 0, img.width, img.height), new Point(0, 0), filter);
		return img;
	}
	
	private function getPixel(img:BitmapData, x:int, y:int):uint {
		return (img.getPixel(x, y)) & 0xff;
	}
	
	// DCT function stolen from http://stackoverflow.com/questions/4240490/problems-with-dct-and-idct-algorithm-in-java
	
	private var c:Array;
	private function initCoefficients():void {
		c = [size];
		
		for (var i:int = 1; i<size; i++) {
			c[i]=1;
		}
		c[0]=1/Math.sqrt(2.0);
	}
	
	private function applyDCT(f:Array):Array {
		var N:int = size;
		
		var F:Array = [N];
		for(var i:int = 0; i < N; i++) {
			F[i] = [N];
		}
		
		for (var u:int = 0; u < N; u++) {
			for (var v:int = 0; v < N; v++) {
				var sum:Number = 0.0;
				for (i = 0; i < N; i++) {
					for (var j:int = 0; j < N; j++) {
						sum+=Math.cos(((2*i+1)/(2.0*N))*u*Math.PI)*Math.cos(((2*j+1)/(2.0*N))*v*Math.PI)*(f[i][j]);
					}
				}
				sum*=((c[u]*c[v])/4.0);
				F[u][v] = sum;
			}
		}
		return F;
	}
}