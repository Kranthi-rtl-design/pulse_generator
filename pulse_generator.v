module pulse_generator (
  input wire clk,
  input wire rst_n,       // Active-low reset
  input wire data_in,
  output reg out
);

  reg data_ff1, data_ff2;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      data_ff1 <= 0;
      data_ff2 <= 0;
      out <= 0;
    end else begin
      data_ff1 <= data_in;
      data_ff2 <= data_ff1;
      out <= data_ff1 & ~data_ff2; // One-cycle pulse on rising edge
    end
  end

endmodule
