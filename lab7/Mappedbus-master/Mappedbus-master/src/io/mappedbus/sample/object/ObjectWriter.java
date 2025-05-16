package io.mappedbus.sample.object;
import io.mappedbus.main.MappedBusWriter;

public class ObjectWriter {

	public static void main(String[] args) {
		ObjectWriter writer = new ObjectWriter();
		writer.run(1);
	}

	public void run(int source) {
		try {
			MappedBusWriter writer = new MappedBusWriter("C:/Users/denis/OneDrive/Рабочий стол/Lab7/test1", 2000000L, 12);
			writer.open();
			
			PriceUpdate priceUpdate = new PriceUpdate();

			for (int i = 0; i < 1000; i++) {
				priceUpdate.setSource(source);
				priceUpdate.setPrice(i * 2);
				priceUpdate.setQuantity(i * 4);
				writer.write(priceUpdate);
				Thread.sleep(1000);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}