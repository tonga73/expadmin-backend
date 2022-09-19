import { Module } from '@nestjs/common';
import { RecordsService } from './records.service';
import { RecordsController } from './records.controller';

import { PrismaService } from '../prisma.service';

@Module({
  controllers: [RecordsController],
  providers: [RecordsService, PrismaService],
  exports: [RecordsService],
})
export class RecordsModule {}
