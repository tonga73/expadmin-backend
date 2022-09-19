import { Module } from '@nestjs/common';
import { OfficesService } from './offices.service';
import { OfficesController } from './offices.controller';

import { PrismaService } from '../prisma.service';

@Module({
  controllers: [OfficesController],
  providers: [OfficesService, PrismaService],
  exports: [OfficesService],
})
export class OfficesModule {}
