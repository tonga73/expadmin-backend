/*
  Warnings:

  - A unique constraint covering the columns `[order]` on the table `Record` will be added. If there are existing duplicate values, this will fail.
  - Made the column `order` on table `Record` required. This step will fail if there are existing NULL values in that column.

*/
-- AlterTable
ALTER TABLE "Record" ADD COLUMN     "code" TEXT,
ALTER COLUMN "order" SET NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "Record_order_key" ON "Record"("order");
