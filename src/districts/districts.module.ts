import { Module } from '@nestjs/common';
import { DistrictsService } from './districts.service';
import { DistrictsController } from './districts.controller';

import { PrismaService } from '../prisma.service';

@Module({
  controllers: [DistrictsController],
  providers: [DistrictsService, PrismaService],
  exports: [DistrictsService],
})
export class DistrictsModule {}
